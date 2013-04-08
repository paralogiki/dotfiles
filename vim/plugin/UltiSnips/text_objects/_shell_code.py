#!/usr/bin/env python
# encoding: utf-8

import os
import subprocess
import stat
import tempfile

from UltiSnips.compatibility import as_unicode
from UltiSnips.text_objects._base import NoneditableTextObject

class ShellCode(NoneditableTextObject):
    def __init__(self, parent, token):
        NoneditableTextObject.__init__(self, parent, token)

        self._code = token.code.replace("\\`", "`")
        self._tmpdir = self._get_tmp()

    def _chomp(self, string):
        if len(string) and string[-1] == '\n':
            string = string[:-1]
        if len(string) and string[-1] == '\r':
            string = string[:-1]
        return string

    def _run(self, cmd, tmpdir):
        # Write the code to a temporary file
        handle, path = tempfile.mkstemp(text=True, dir=tmpdir)
        os.write(handle, cmd.encode("utf-8"))
        os.close(handle)
        os.chmod(path, stat.S_IRWXU)

        # Execute the file and read stdout
        proc = subprocess.Popen(path, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        proc.wait()
        stdout, stderr = proc.communicate()

        os.unlink(path)
        return self._chomp(stdout.encode('utf-8'))

    def _get_tmp(self):
        # find an executable tmp directory
        userdir = os.path.expanduser("~")
        for testdir in [tempfile.gettempdir(), os.path.join(userdir, '.cache'), os.path.join(userdir, '.tmp'), userdir]:
            if not os.path.exists(testdir) or not self._run('echo success', testdir) == 'success':
                continue
            return testdir
        return ''

    def _update(self, done, not_done):
        if self._tmpdir == '':
            output = "Unable to find executable tmp directory, check noexec on /tmp"
        else:
            output = self._run(self._code, self._tmpdir)

        self.overwrite(output)
        self._parent._del_child(self)

        return True

