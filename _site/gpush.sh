#!/bin/sh

COMMIT_CONTENT=$1
git add -A
echo "begin to commit all, because $COMMIT_CONTENT" 
git commit -m $COMMIT_CONTENT
echo "git push"
git push

