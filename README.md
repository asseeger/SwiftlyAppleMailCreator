# SwiftlyAppleMailCreator

## Purpose
Command Line Tool / Executable to _compose_ a new mail with attachments.

This executable is to be used with Apple Mail, as attaching a file is for 
reasons that are beyond the scope of this project does _not_ work with MS Outlook.

## Versioning
2021-07-01 Version 1.1.0 allowing multiple attachments (variadically from `CommandLine.arguments[4]` onwards)
2020-09-28 Version 1.0.0

This project is version controlled by git.

## Usage: Required Arguments
- Email Adress
- Subject
- Message Body
- from parameter 5: absolut path(s) to the attachment file(s)

## Security
Sandboxing is deactivated for this small project.

## Resources
[https://www.fivestars.blog/articles/ultimate-guide-swift-executables/](https://www.fivestars.blog/articles/ultimate-guide-swift-executables/)

## Disclaimer
As mentioned above, this project is meant to work with Apple Mail and is confirmed working 
with that Mail client on
- macOS 10.15.7+
- macOS 11+
