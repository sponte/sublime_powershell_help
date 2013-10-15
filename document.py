import sublime, sublime_plugin
import subprocess, threading
import re
from os.path import dirname, realpath

class DocumentCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        rootFolder = dirname(realpath(__file__))
        
        view = self.view

        for region in view.sel():
            line = view.line(region)
            line_contents = view.substr(line)
            
            cmdletName = re.search('\s*function\s*([\w\d\-]+)', line_contents).group(1)
            
            executer = RunExternalThread("powershell -InputFormat None -NonInteractive -File \"{0}\\Get-HelpTemplate.ps1\" {1}".format(rootFolder, cmdletName))
            executer.start()
            executer.join(5)

            if executer.isAlive():
                executer.kill()
                executer.error = '"{0}" killed after {1} seconds'.format(cmdletName, 5)

            if executer.error:
                sublime.error_message(executer.error)
            else:
                view.insert(edit, line.begin(), executer.output)

class RunExternalThread(threading.Thread):

    command = None
    output = None
    error = None
    process = None

    def __init__(self, command):
        threading.Thread.__init__(self)
        self.command = command

    def run(self):
        self.process = subprocess.Popen(
            self.command,
            shell = True,
            bufsize = -1,
            stdout = subprocess.PIPE,
            stderr = subprocess.PIPE,
            stdin = subprocess.PIPE,
            universal_newlines = True)

        self.output, self.error = self.process.communicate()

    def kill(self):
        self.process.kill()