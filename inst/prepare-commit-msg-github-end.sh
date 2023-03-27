#!/usr/bin/env bash
#
# This hook works for branches named such as "123-description" and will add
# "(#23) " to the commit message.
#
# 123-description >> (#123)
#
# Example:
#
# ```
# $ git checkout -b 123-description
# $ echo "commit msg" > foo
# $ sh .git/hooks/prepare-commit-msg foo
# $ cat foo
# #> commit msg (#123)
# ```

# get current branch
BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

# search issue id in the branch name, such a "123-description" or
# "XXX-123-description"
ISSUE_ID=$(echo $BRANCH_NAME | sed -nE 's,(^[0-9]+)-.+,\1,p')

# only prepare commit message if pattern matched and issue id was found
if [[ ! -z $ISSUE_ID ]]
then
  # $1 is the name of the file containing the commit message
  echo -e "$(cat $1) (#$ISSUE_ID)" > "$1"
fi
