## Setup with configuration 
```
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
git init
git clone <repository_url>

```
## Working with Changes
```
git status
git add <file_or_folder>
git add .  # Add all changes
git commit -m "Your commit message"
git diff

```
## Branch Management
```
git branch                 #List, create, or delete branches
git branch <branch_name>   # Create a new branch
git branch -d <branch_name># Delete a branch
git checkout <branch_name>
git switch <branch_name>   #Switch to another branch.
git merge <branch_name>    #Merge changes from one branch into another.

```
Undoing Changes
```
git restore <file_name>
git restore --staged <file_name> # Unstage a file

git reset --soft <commit_hash>   # Undo commit, keep changes staged
git reset --mixed <commit_hash>  # Undo commit, unstage changes
git reset --hard <commit_hash>   # Undo commit and discard changes

git revert <commit_hash>
```
## Viewing History
```
git log
git log --oneline --graph --decorate  # Compact and visual log

git show <commit_hash>

git blame <file_name>

```

## Stashing Changes
```
git stash          # Stash changes
git stash apply    # Apply the most recent stash
git stash pop      # Apply and remove the most recent stash
git stash list     # View stashed changes
```
## Tagging
```
git tag <tag_name>             # Create a tag
git tag                        # List tags
git tag -d <tag_name>          # Delete a tag
git push origin <tag_name>     # Push a tag
git push origin --tags         # Push all tags
```
## Tips 
```
git status
git commit -am "Message" && git push
git log --oneline
```

