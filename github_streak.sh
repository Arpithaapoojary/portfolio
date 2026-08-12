#!/bin/bash

# ==============================================================================
# GitHub Streak Generator
# ==============================================================================
# This script will generate empty commits for the past 365 days to fill your 
# GitHub contribution graph. 
#
# PREREQUISITES:
# 1. This must be run inside a Git repository.
# 2. You should run this in Git Bash (if on Windows) or any Linux/Mac terminal.
#
# INSTRUCTIONS:
# 1. Make the script executable: chmod +x github_streak.sh
# 2. Run the script: ./github_streak.sh
# 3. Push to GitHub: git push origin main
# ==============================================================================

# File to update to ensure there are changes if empty commits aren't working
FILE="streak_tracker.txt"

# Number of days to backdate
DAYS=365

echo "Starting GitHub Streak Generation for the past $DAYS days..."

for i in $(seq $DAYS -1 1)
do
    # Calculate the date for the commit (i days ago)
    # Works on MacOS and Linux (Git Bash)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        COMMIT_DATE=$(date -v-"${i}"d +"%Y-%m-%dT12:00:00")
    else
        COMMIT_DATE=$(date -d "$i days ago" +"%Y-%m-%dT12:00:00")
    fi

    # Update a file to make sure a commit is created
    echo "Commit for $COMMIT_DATE" >> $FILE
    git add $FILE

    # Create the commit with the specific date
    GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" git commit -m "Streak commit for $COMMIT_DATE"
    
    echo "Created commit for $COMMIT_DATE"
done

echo ""
echo "Done! 🎉"
echo "Now run: git push origin main"
echo "Note: If your branch is not named 'main', replace 'main' with your branch name (e.g., 'master')."
