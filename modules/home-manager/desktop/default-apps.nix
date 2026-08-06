{ ... }:

let
  browser = "firefox.desktop";
  image = "org.kde.gwenview.desktop";
  video = "mpv.desktop";
  audio = "deadbeef.desktop";
  document = "org.kde.okular.desktop";
  archive = "org.kde.ark.desktop";
  editor = "emacsclient.desktop";
  fileManager = "org.gnome.Nautilus.desktop";

  writer = "writer.desktop";
  calc = "calc.desktop";
  impress = "impress.desktop";

  # Assign the same handler to a whole list of MIME types.
  forEach =
    app: types:
    builtins.listToAttrs (
      map (t: {
        name = t;
        value = app;
      }) types
    );
in
{
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;

    defaultApplications =
      # Web browser
      forEach browser [
        "text/html"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
      ]
      // forEach image [
        "image/jpeg"
        "image/png"
        "image/gif"
        "image/webp"
        "image/bmp"
        "image/tiff"
        "image/x-icon"
        "image/svg+xml"
        "image/heif"
        "image/heic"
        "image/avif"
      ]
      // forEach video [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/x-msvideo"
        "video/quicktime"
        "video/mpeg"
        "video/x-flv"
        "video/3gpp"
        "video/ogg"
        "video/x-m4v"
      ]
      // forEach audio [
        "audio/mpeg"
        "audio/mp3"
        "audio/flac"
        "audio/x-flac"
        "audio/ogg"
        "audio/x-vorbis+ogg"
        "audio/opus"
        "audio/mp4"
        "audio/m4a"
        "audio/aac"
        "audio/wav"
        "audio/x-wav"
        "audio/x-aiff"
        "audio/x-ms-wma"
        "audio/x-mpegurl"
        "application/ogg"
      ]
      // forEach document [
        "application/pdf"
        "application/epub+zip"
        "image/vnd.djvu"
        "application/postscript"
        "application/x-cbz"
        "application/x-cbr"
      ]
      // forEach writer [
        "application/vnd.oasis.opendocument.text"
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/rtf"
      ]
      // forEach calc [
        "application/vnd.oasis.opendocument.spreadsheet"
        "application/vnd.ms-excel"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "text/csv"
      ]
      // forEach impress [
        "application/vnd.oasis.opendocument.presentation"
        "application/vnd.ms-powerpoint"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      ]
      // forEach archive [
        "application/zip"
        "application/x-7z-compressed"
        "application/vnd.rar"
        "application/x-rar"
        "application/x-tar"
        "application/gzip"
        "application/x-bzip2"
        "application/x-xz"
        "application/zstd"
        "application/x-compressed-tar"
      ]
      // forEach editor [
        "text/plain"
        "text/markdown"
        "text/xml"
        "application/xml"
        "application/json"
        "application/x-shellscript"
        "text/x-python"
        "text/x-csrc"
        "text/x-chdr"
      ]
      // forEach fileManager [
        "inode/directory"
      ]
      // {
        "x-scheme-handler/discord" = "vesktop.desktop";
      }
      // forEach "Cider.desktop" [
        "x-scheme-handler/cider"
        "x-scheme-handler/itms"
        "x-scheme-handler/itmss"
        "x-scheme-handler/music"
        "x-scheme-handler/itunes"
      ];
  };
}
