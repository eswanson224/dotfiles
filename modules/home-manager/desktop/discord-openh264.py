"""Align Discord's codec downloader with its packaged native bridge."""

import re
import sys
from pathlib import Path


path = Path(sys.argv[1])
source = path.read_text()
filename = "libopenh264-2.5.1-linux64.7.so"
# SHA-256 supplied by Discord's frontend for Cisco's uncompressed 2.5.1 binary.
checksum = "d828a944d4d2bb64195ada89cf2cde9bc41733b1547d0788ef49fb8cb231b76f"
versions = re.findall(r'exports\.OPENH264_LIBRARY_FILE_NAME="([^"]+)"', source)
if versions != [filename]:
    raise SystemExit(
        f"Discord's native OpenH264 path changed to {versions!r}; "
        "reassess/remove the OpenH264 compatibility workaround."
    )

replacements = {
    "async function maybeDownloadOpenH264(cdnURL,fileName,sha256,onProgress){": (
        "async function maybeDownloadOpenH264(cdnURL,fileName,sha256,onProgress){"
        "if(fileName!==exports.OPENH264_LIBRARY_FILE_NAME){"
        f'fileName="{filename}";'
        'cdnURL="https://ciscobinary.openh264.org/"+fileName+".bz2";'
        f'sha256="{checksum}";'
        "}"
    ),
    "async function cleanupUnusedOpenH264Files(neededFileNames){": (
        "async function cleanupUnusedOpenH264Files(neededFileNames){"
        "neededFileNames=[...new Set([...neededFileNames,"
        "exports.OPENH264_LIBRARY_FILE_NAME])];"
    ),
}
for old, new in replacements.items():
    if source.count(old) != 1:
        raise SystemExit(f"Discord's OpenH264 implementation changed: {old}")
    source = source.replace(old, new)

path.write_text(source)
