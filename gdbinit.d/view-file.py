import gdb
import os

class ViewFile (gdb.Command):
    """View file in editor"""

    def __init__(self):
        super(ViewFile, self).__init__("view-file", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        sal = gdb.selected_frame().find_sal()
        fname = sal.symtab.fullname()
        lnum = sal.line
        editor = os.environ.get("EDITOR", "vi")
        gdb.execute(f'shell "{editor}" "{fname}" +{lnum}')

ViewFile()

