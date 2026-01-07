# Linux Command Line Basics

## Introduction

This page covers essential Linux commands you'll use daily in the lab. Don't worry about memorizing everything - you'll learn through practice!

## File System Navigation

### pwd - Print Working Directory

```bash
pwd
```

Shows your current location in the file system.

### ls - List Files

```bash
ls                  # List files in current directory
ls -l              # Long format with details
ls -lh             # Human-readable file sizes
ls -a              # Show hidden files (starting with .)
ls /path/to/dir    # List specific directory
```

### cd - Change Directory

```bash
cd /path/to/directory    # Go to specific directory
cd ..                    # Go up one level
cd ~                     # Go to your home directory
cd -                     # Go to previous directory
```

## File Operations

### Creating Files and Directories

```bash
mkdir directory_name        # Create a directory
mkdir -p path/to/nested/dir # Create nested directories
touch filename.txt          # Create empty file
```

### Copying, Moving, and Deleting

```bash
cp source.txt destination.txt           # Copy file
cp -r source_dir/ destination_dir/     # Copy directory
mv oldname.txt newname.txt              # Rename/move file
rm file.txt                             # Delete file
rm -r directory/                        # Delete directory
```

!!! danger
    Be careful with `rm` - there's no recycle bin! Deleted files are gone forever.

## Viewing Files

```bash
cat file.txt              # Display entire file
less file.txt             # View file page by page (q to quit)
head file.txt             # Show first 10 lines
head -n 20 file.txt       # Show first 20 lines
tail file.txt             # Show last 10 lines
tail -f logfile.txt       # Follow file (useful for logs)
```

## File Permissions

[Content to be added: Understanding rwx permissions, chmod basics]

## Searching and Finding

### grep - Search in Files

```bash
grep "search_term" file.txt
grep -r "search_term" directory/    # Recursive search
grep -i "search_term" file.txt      # Case-insensitive
```

### find - Find Files

```bash
find . -name "filename.txt"
find . -name "*.py"                 # Find all Python files
find . -type d -name "data"         # Find directories named "data"
```

## Working with Your Two Homes

Remember, you have two home directories:

```bash
# Your local home (fast, but not shared)
cd ~
cd /home/your-username

# Your NAS home (shared across all servers)
cd /nas/homes/your-username
```

## Disk Usage

```bash
df -h                    # Show disk space
du -sh directory/        # Show directory size
du -h --max-depth=1      # Show size of subdirectories
```

## Process Management

```bash
top                      # View running processes (q to quit)
htop                     # Better version of top (if installed)
ps aux | grep python     # Find Python processes
kill PID                 # Stop a process
```

## System Information

```bash
hostname                 # Show server name
whoami                   # Show your username
uptime                   # Show how long server has been running
```

## Tips for Beginners

### Tab Completion

Press `Tab` to auto-complete file names and commands. Press `Tab` twice to see all possibilities.

### Command History

- Use `↑` and `↓` arrows to navigate previous commands
- `Ctrl+R` to search command history

### Getting Help

```bash
man command              # Show manual for command
command --help           # Show quick help
```

## Quick Reference

[Content to be added: Cheat sheet table of most common commands]

---

**Next Step**: Learn about [Data Storage & Organization](data-storage.md)
