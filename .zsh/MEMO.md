# memos for zsh

## TODO

- [ ] This memo file should be moved to other repo and linked from README.md

## Alias for xdg-open

in `.zprofile`:

```bash
alias x='xdg-open'
```
This creates a shell alias named `x` that runs the command `xdg-open`.

## Purpose:
This makes it quicker and easier to open files or URLs from the command line.
Instead of typing `xdg-open <file-or-url>`, you can just type `x <file-or-url>`.
The `xdg-open` command opens a file or URL in the user's prefferred application (for example, a PDF in the default viewer or a website in the default browser).

`xdg-open` is a command-line utility available on many Linux and Unix-like systems.
Its primary purpose is to open a file or URL in the user's preferred application, as defined by the desktop environment.

For example:

* Running `xdg-open file.pdf` will open `file.pdf` in the default PDF viewer.
* Running `xdg-open https://www.example.com` will open the website in your default web browser.

It works as a universal "open" command, similar to `open` on macOS or `start` on Windows, making it easier to open files and links from scripts or the terminal without needing to know the specifc application to use.
