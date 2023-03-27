#!/usr/bin/env bash
# Based on https://serebrov.github.io/html/2019-06-16-git-hook-to-add-issue-number-to-commit-message.html
#
# This hook works for branches named such as "ABC-123-description" and will add
# "[ABC-123] " to the commit message.
#
# ABC-123-description >> [ABC-123]
#
# Example:
#
# ```
# $ git checkout -b ABC-123-description
# $ echo "commit msg" > foo
# $ sh .git/hooks/prepare-commit-msg foo
# $ cat foo
# #> commit msg [ABC-123]
# ```

# get current branch
BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

# search issue id in the branch name, such a "ABC-123-description"
ISSUE_ID=$(echo $BRANCH_NAME | sed -nE 's,(^[A-Z]+-?[0-9]+)-.+,\1,p')

# only prepare commit message if pattern matched and issue id was found
if [[ ! -z $ISSUE_ID ]]
then
  # $1 is the name of the file containing the commit message
  echo -e "$(cat $1) [$ISSUE_ID] " > "$1"
fi
