{
  name = "everforest";
  
  colors = {
    # Background colors
    bg0 = "#2d353b";
    bg1 = "#343f44";
    bg2 = "#3d484d";
    bg3 = "#475258";
    bg4 = "#4f585e";
    bg5 = "#56635f";
    
    # Foreground colors
    fg = "#d3c6aa";
    
    # Gray
    gray0 = "#7a8478";
    gray1 = "#859289";
    gray2 = "#9da9a0";
    
    # Colors
    red = "#e67e80";
    orange = "#e69875";
    yellow = "#dbbc7f";
    green = "#a7c080";
    aqua = "#83c092";
    blue = "#7fbbb3";
    purple = "#d699b6";
  };
  
  # Application-specific theme configurations
  zellij = {
    theme_name = "everforest-dark";
    fg = "#d3c6aa";
    bg = "#2d353b";
    black = "#2d353b";
    red = "#e67e80";
    green = "#a7c080";
    yellow = "#dbbc7f";
    blue = "#7fbbb3";
    magenta = "#d699b6";
    cyan = "#83c092";
    white = "#9da9a0";
    orange = "#e69875";
  };
  
  foot = {
    background = "2d353b";
    foreground = "d3c6aa";
    regular0 = "2d353b";
    regular1 = "e67e80";
    regular2 = "a7c080";
    regular3 = "dbbc7f";
    regular4 = "7fbbb3";
    regular5 = "d699b6";
    regular6 = "83c092";
    regular7 = "9da9a0";
    bright0 = "7a8478";
    bright1 = "e67e80";
    bright2 = "a7c080";
    bright3 = "dbbc7f";
    bright4 = "7fbbb3";
    bright5 = "d699b6";
    bright6 = "83c092";
    bright7 = "d3c6aa";
  };
  
  waybar = {
    background = "rgba(45, 53, 59, 0.9)";
    foreground = "#d3c6aa";
    border = "rgba(71, 82, 88, 0.3)";
    workspace_active = "rgba(167, 192, 128, 0.8)";
    workspace_visible = "rgba(122, 132, 120, 0.6)";
    workspace_inactive = "rgba(157, 169, 160, 0.6)";
    warning = "#dbbc7f";
    critical = "#e67e80";
    charging = "#a7c080";
    power_button = "#e67e80";
    power_button_hover = "#e67e80";
  };
  
  wofi = {
    window_bg = "#2d353b";
    window_border = "#475258";
    input_bg = "#343f44";
    input_fg = "#d3c6aa";
    text_fg = "#d3c6aa";
    entry_selected_bg = "#7fbbb3";
    entry_selected_fg = "#2d353b";
  };
  
  nvf = {
    name = "everforest";
    style = "dark";
  };
  
  helix = {
    name = "everforest_dark";
  };
  
  zed = {
    dark = "Everforest Dark";
  };
  
  neovim = {
    colorscheme = "everforest";
  };
  
  alacritty = {
    colors = {
      primary = {
        background = "#2d353b";
        foreground = "#d3c6aa";
        bright_foreground = "#d3c6aa";
      };
      
      normal = {
        black = "#2d353b";
        red = "#e67e80";
        green = "#a7c080";
        yellow = "#dbbc7f";
        blue = "#7fbbb3";
        magenta = "#d699b6";
        cyan = "#83c092";
        white = "#9da9a0";
      };
      
      bright = {
        black = "#7a8478";
        red = "#e67e80";
        green = "#a7c080";
        yellow = "#dbbc7f";
        blue = "#7fbbb3";
        magenta = "#d699b6";
        cyan = "#83c092";
        white = "#d3c6aa";
      };
      
      selection = {
        text = "#2d353b";
        background = "#d3c6aa";
      };
    };
  };
}