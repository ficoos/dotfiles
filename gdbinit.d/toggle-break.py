import gdb
import os

class ToggleBreakpoint (gdb.Command):
    """Toggle breakpoint"""

    def __init__(self):
        super(ToggleBreakpoint, self).__init__("toggle-break", gdb.COMMAND_USER)

    def invoke(self, args, from_tty):
        try:
            sal = gdb.selected_frame().find_sal()
            fname = sal.symtab.fullname()
            lnum = sal.line
        except Exception as e:
            gdb.write(str(e) + '\n')
        else:
            try:
                gdb.execute(f'clear {fname}:{lnum}')
            except gdb.error:
                gdb.execute(f'break {fname}:{lnum}')

ToggleBreakpoint()

