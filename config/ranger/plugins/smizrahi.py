from datetime import datetime

import ranger.api
from ranger.core.linemode import SizeMtimeLinemode

from .devicons import devicon

@ranger.api.register_linemode
class DevIconsLinemode(SizeMtimeLinemode):
    name = "sizemtime"

    def filetitle(self, file, metadata):
        return devicon(file) + ' ' + file.relative_path

