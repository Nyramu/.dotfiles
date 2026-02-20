{ ... }:

{
  programs.yazi = {
    settings = {
      open.rules = [
        {
          mime = "application/zip";
          use = "extract";
        }
        {
          mime = "application/zip-compressed";
          use = "extract";
        }
        {
          mime = "application/gzip";
          use = "extract";
        }
        {
          mime = "application/x-tar";
          use = "extract";
        }
        {
          mime = "application/x-bzip";
          use = "extract";
        }
        {
          mime = "application/x-bzip2";
          use = "extract";
        }
        {
          mime = "application/x-xz";
          use = "extract";
        }
        {
          mime = "application/x-7z-compressed";
          use = "extract";
        }
        {
          mime = "application/x-rar";
          use = "extract";
        }
        {
          mime = "application/x-rar-compressed";
          use = "extract";
        }
        {
          mime = "application/vnd-rar";
          use = "extract";
        }
        {
          mime = "application/x-zstd";
          use = "extract";
        }
        {
          mime = "application/x-cpio";
          use = "extract";
        }
        {
          mime = "application/x-lzma";
          use = "extract";
        }
        {
          mime = "text/*";
          use = "xdg";
        }
        {
          mime = "video/*";
          use = "xdg";
        }
        {
          mime = "image/*";
          use = "xdg";
        }
        {
          mime = "audio/*";
          use = "xdg";
        }
        {
          mime = "application/*";
          use = "xdg";
        }
      ];
    };
  };
}
