#!/usr/bin/env python3
#
#===- clang-format-diff.py - ClangFormat Diff Reformatter ----*- python -*--===#
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#===------------------------------------------------------------------------===#

"""
This script reads input from a unified diff and reformats all the changed
lines. This is useful to reformat all the lines touched by a specific patch.
Example usage for git/svn users:

  git diff -U0 --no-color --relative HEAD^ | clang-format-diff.py -p1 -i
  svn diff --diff-cmd=diff -x-U0 | clang-format-diff.py -i

It should be noted that the filename contained in the diff is used unmodified
to determine the source file to update. Users calling this script directly
should be careful to ensure that the path in the diff is correct relative to the
current working directory.
"""
from __future__ import absolute_import, division, print_function
from pathlib import Path

import argparse
import difflib
import re
import subprocess
import sys
import shutil

if sys.version_info.major >= 3:
    from io import StringIO
else:
    from io import BytesIO as StringIO


def xcode_path() -> str:
    """
    Get the current selected Xcode app path in the system
    :return: The path to the current selected Xcode in the system
    """
    xcode_select_path = '/usr/bin/xcode-select'
    default_path = '/Applications/Xcode.app'

    if not Path(xcode_select_path).is_file():
        return default_path

    ret = subprocess.run([xcode_select_path, '--print-path'],
                         check=False, capture_output=True, encoding='UTF-8')

    match = re.search(r"(.+\.app)/.*", ret.stdout)
    if not match:
        return default_path

    return match.groups()[0]


def clang_format_bin_path() -> str:
    clang_format_xcode = f'{xcode_path()}/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/local/bin/clang-format'
    clang_format_bin = shutil.which('clang-format')

    if Path(clang_format_xcode).is_file():
        clang_format = clang_format_xcode
    elif clang_format_bin:
        clang_format = clang_format_bin
    else:
        raise FileNotFoundError('No clang-format binary found in system')

    return clang_format

def default_arg_clang_format() -> str:
    try:
        return clang_format_bin_path()
    except FileNotFoundError as e:
        return "No-default-clang-format-found"

class RawTextArgumentDefaultsHelpFormatter(
        argparse.ArgumentDefaultsHelpFormatter,
        argparse.RawDescriptionHelpFormatter
    ):
    pass

def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-i', '--inplace', action='store_true', default=False,
                        help='apply edits to files instead of displaying a diff')
    parser.add_argument('-p', metavar='NUM', default=0,
                        help='strip the smallest prefix containing P slashes')
    parser.add_argument('--regex', metavar='PATTERN', default=None,
                        help='custom pattern selecting file paths to reformat '
                        '(case sensitive, overrides --iregex)')
    parser.add_argument('--iregex', metavar='PATTERN', default=r'.*\.(cpp|cc|c\+\+|cxx|cppm|ccm|cxxm|c\+\+m|c|cl|h|hh|hpp|hxx'
                        r'|m|mm|inc|js|ts|proto|protodevel|java|cs|json)',
                        help='custom pattern selecting file paths to reformat '
                        '(case insensitive, overridden by --regex)')
    parser.add_argument('--sort-includes', action='store_true', default=False,
                        help='let clang-format sort include blocks')
    parser.add_argument('-v', '--verbose', action='store_true',
                        help='be more verbose, ineffective without -i')
    parser.add_argument('--style',
                        help='formatting style to apply (file, LLVM, GNU, Google, Chromium, '
                        'Microsoft, Mozilla, WebKit)', default='file')
    parser.add_argument('--fallback-style',
                        help='The name of the predefined style used as a '
                        'fallback in case clang-format is invoked with '
                        '--style=file, but can not find the .clang-format '
                        'file to use.')
    parser.add_argument('--binary', default=default_arg_clang_format(),
                        help='location of binary to use for clang-format')
    args = parser.parse_args()

    # Extract changed lines for each file.
    filename = None
    lines_by_file = {}
    for line in sys.stdin:
        match = re.search(r'^\+\+\+\ (.*?/){%s}(\S*)' % args.p, line)
        if match:
            filename = match.group(2)
        if filename is None:
            continue

        if args.regex is not None:
            if not re.match('^%s$' % args.regex, filename):
                continue
        else:
            if not re.match('^%s$' % args.iregex, filename, re.IGNORECASE):
                continue

        match = re.search(r'^@@.*\+(\d+)(,(\d+))?', line)
        if match:
            start_line = int(match.group(1))
            line_count = 1
            if match.group(3):
                line_count = int(match.group(3))
            # Also format lines range if line_count is 0 in case of deleting
            # surrounding statements.
            end_line = start_line
            if line_count != 0:
                end_line += line_count - 1
            lines_by_file.setdefault(filename, []).extend(
                ['--lines', str(start_line) + ':' + str(end_line)])

    # Reformat files containing changes in place.
    for filename, lines in lines_by_file.items():
        if args.inplace and args.verbose:
            print('Formatting {} lines: {}'.format(filename, ', '.join([l for l in lines if '-lines' not in l])))
        command = [args.binary, filename]
        if args.inplace:
            command.append('-i')
        if args.sort_includes:
            command.append('--sort-includes')
        command.extend(lines)
        if args.style:
            command.extend(['--style', args.style])
        if args.fallback_style:
            command.extend(['--fallback-style', args.fallback_style])

        try:
            p = subprocess.Popen(command,
                                 stdout=subprocess.PIPE,
                                 stderr=None,
                                 stdin=subprocess.PIPE,
                                 universal_newlines=True)
        except OSError as e:
            # Give the user more context when clang-format isn't
            # found/isn't executable, etc.
            raise RuntimeError(
                'Failed to run "%s" - %s"' % (" ".join(command), e.strerror))

        stdout, stderr = p.communicate()
        if p.returncode != 0:
            sys.exit(p.returncode)

        if not args.inplace:
            with open(filename) as f:
                code = f.readlines()
            formatted_code = StringIO(stdout).readlines()
            diff = difflib.unified_diff(code, formatted_code,
                                        filename, filename,
                                        '(before formatting)', '(after formatting)')
            diff_string = ''.join(diff)
            if len(diff_string) > 0:
                sys.stdout.write(diff_string)


if __name__ == '__main__':
    main()
