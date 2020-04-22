import errno
import os


class Strerror(gdb.Command):
    """Translate errno numbers"""

    def __init__(self):
        super(Strerror, self).__init__("strerror", gdb.COMMAND_USER)

    def invoke(self, n, from_tty):
        try:
            n = int(n)
        except:
            print("Invalid error code '%s'" % (n,))
            return

        print("%s (%s)" % (os.strerror(n), errno.errorcode.get(n)))


Strerror()
