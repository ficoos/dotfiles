import gdb
import os

class KakSource(Dashboard.Module):
    '''Show the program source code, if available in kakoune'''

    def __init__(self):
        pass

    def label(self):
        return 'KakSource'

    def lines(self, term_width, term_height, style_changed):
        if not gdb.selected_thread().is_stopped():
            return []

        sal = gdb.selected_frame().find_sal()
        if sal.symtab is None:
            return ["No file for current frame"]

        fname = sal.symtab.fullname()
        lnum = sal.line
        gdb.execute(
            f'shell echo \'eval -client "{self.client}" edit -readonly {fname} {lnum}\' | kak -p "{self.session}"',
        )

        return []

    def attributes(self):
        return {
            'session': {
                'doc': '''Kakoune session to control''',
                'default': '',
                'type': str,
                'name': 'session',

            },
            'client': {
                'doc': '''Kakoune client to control''',
                'default': '%opt{jumpclient}',
                'type': str,
                'name': 'client',
            }
        }

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

