#!/usr/bin/env bash

set -e

CURR_YEAR=$(date +"%Y")
JAVA_FILE=$(find ./src/ -type f -name *.java -print -quit)
echo "Current year will be taken from $JAVA_FILE"
PREV_YEAR=$(grep "Copyright" "$JAVA_FILE" | cut -d " " -f 4 | cut -d '-' -f 2)
echo "CURR_YEAR=$CURR_YEAR"
echo "PREV_YEAR=$PREV_YEAR"

./.ci/bump-license-year.sh "$PREV_YEAR" "$CURR_YEAR" .
git add . && git commit -m "minor: bump year to $CURR_YEAR" && git push origin master

mkdir -p .ci-temp/bump-year
cd .ci-temp/bump-year

git clone git@github.com:Rahulkhinchi03/action-testing-2.git

./../../.ci/bump-license-year.sh "$PREV_YEAR" "$CURR_YEAR" action-testing-2

cd action-testing-2
git add . && git commit -m "minor: bump year to $CURR_YEAR" && git push origin master
cd ../
