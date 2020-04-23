import gdb
import os

class RunOrContinue (gdb.Command):
    """Run or continue"""

    def __init__(self):
        super(RunOrContinue, self).__init__("run-or-continue", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        try:
            # are we running
            gdb.selected_frame()
        except gdb.error:
            gdb.execute("run", from_tty, False)
        else:
            gdb.execute("continue", from_tty, False)

RunOrContinue()

