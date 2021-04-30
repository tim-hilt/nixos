{
  enable = true;
  settings = {
    env = {
      TERM = "xterm-256color";
      WINIT_X11_SCALE_FACTOR = "1";
    };
    window = {
      padding = {
        x = 40;
        y = 30;
      };
    };
    font = {
      normal.family = "Hack";
      size = 11.0;
    };
    colors = {
      primary = {
        background = "0x282c34";
        foreground = "0xbbc2cf";
      };
      normal = {
        black = "0x282c34";
        red = "0xff6c6b";
        green = "0x98be65";
        yellow = "0xecbe7b";
        blue = "0x51afef";
        magenta = "0xc678dd";
        cyan = "0x46d9ff";
        white = "0xbbc2cf";
      };
    };
    key_bindings = [{
      key = "Return";
      mods = "Shift";
      chars = "\\x1b[13;2u";
    }];
  };
}
