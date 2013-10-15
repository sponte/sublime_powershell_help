sublime_powershell_help
=======================

Generates powershell help template for the the selected method name

Installation
===================
Clone repository to your packages directory

Sublime 2: %APPDATA%\Sublime Text 2\Packages
Sublime 3: %APPDATA%\Sublime Text 3\Packages

	git clone https://github.com/sponte/sublime_powershell_help.git "%APPDATA%\Sublime Text 3\Packages\sublime_powershell_help"


Usage
=====

Put your cursor on the line where your cmdlet is, press CTRL + SHIFT + P and find Document Cmdlet command. Once you run it it will preped documentation template above the function.

Notes
=====

Your method needs to be discoverable to powershell i.e. it needs to be a exported method in the module that is on the PSModulePath.

Currently there is no error handling and verification. It will prepend documentation twice if you call it twice on the same method.