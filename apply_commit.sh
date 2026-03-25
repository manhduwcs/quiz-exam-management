#!/bin/bash

OLD_REPO_PATH="/home/manhduwcs/Downloads/QuizExam"

while read -r row; do
    hash=$(echo "$row" | jq -r '.old_hash')
    author=$(echo "$row" | jq -r '.author')
    date=$(echo "$row" | jq -r '.date')
    msg=$(echo "$row" | jq -r '.message')

    name=$(echo "$author" | sed 's/ <.*//')
    email=$(echo "$author" | sed 's/.*<\(.*\)>/\1/')

    # 1. Clear current files (except .git) to ensure a clean state for the next commit
    find . -maxdepth 1 ! -name ".git" ! -name "." -exec rm -rf {} +

    # 2. Extract files from the old repo at the specific hash directly into the current folder
    git -C "$OLD_REPO_PATH" archive "$hash" | tar -x

    # 3. Remove node_modules or dist if they were extracted from the old repo
    rm -rf node_modules dist

    # 4. Stage all changes (creates a perfect 1:1 diff of that commit)
    git add -A

    # 5. Commit with unified identity
    GIT_AUTHOR_NAME="$name" \
    GIT_AUTHOR_EMAIL="$email" \
    GIT_AUTHOR_DATE="$date" \
    GIT_COMMITTER_NAME="$name" \
    GIT_COMMITTER_EMAIL="$email" \
    GIT_COMMITTER_DATE="$date" \
    git commit -m "$msg" --no-verify --allow-empty

done < <(jq -c '.[:5][]' commits.json)
# done < <(jq -c '.[]' commits.json)
