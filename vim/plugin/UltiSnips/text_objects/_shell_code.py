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

    def _update(self, done, not_done):
        # Write the code to a temporary file
        userdir = os.path.expanduser("~")
        output = ''
        stderr = ''
        for tmpdir in [tempfile.gettempdir(),userdir+'/.cache',userdir+'/.tmp',userdir]:
          if os.path.exists(tmpdir) == 0:
            continue;
          handle, path = tempfile.mkstemp(text=True,dir=tmpdir)
          os.write(handle, self._code.encode("utf-8"))
          os.close(handle)
          os.chmod(path, stat.S_IRWXU)

          # Execute the file and read stdout
          proc = subprocess.Popen(path, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
          proc.wait()
          stdout, stderr = proc.communicate()
          if len(stdout) == 0 and len(stderr) > 0:
            continue
          output = as_unicode(stdout)

          if len(output) and output[-1] == '\n':
              output = output[:-1]
          if len(output) and output[-1] == '\r':
              output = output[:-1]

          os.unlink(path)

        if len(output) == 0:
          output = "Error '" + self._code.encode('utf-8') + "' returned empty result" 
          if len(stderr) > 0:
            if len(stderr) and stderr[-1] == '\n':
                stderr = stderr[:-1]
            if len(stderr) and stderr[-1] == '\r':
                stderr = stderr[:-1]
            output += ", stderr: " + stderr
        self.overwrite(output)
        self._parent._del_child(self)

        return True


