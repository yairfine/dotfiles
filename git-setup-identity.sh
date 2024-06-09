#!/usr/bin/env sh -e

echo "[Git identity Setup] Type in your first and last name (i.e John Doe): "
read FULL_NAME

echo "[Git identity Setup] Type in your email address (i.e john.doe@email.com): "
read EMAIL

git config --global user.email "$EMAIL"
git config --global user.name "$FULL_NAME"

echo "👌 Awesome, git all set."
echo ""
