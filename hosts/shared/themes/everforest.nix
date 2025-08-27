{
  name = "everforest";
  
  colors = {
    # Background colors
    bg0_hard = "#232a2e";
    bg0_normal = "#2d353b";
    bg0_soft = "#323c41";
    bg1 = "#343f44";
    bg2 = "#3d484d";
    bg3 = "#475258";
    bg4 = "#4f585e";
    
    # Foreground colors
    fg = "#d3c6aa";
    fg0 = "#d3c6aa";
    fg1 = "#d3c6aa";
    fg2 = "#9da9a0";
    fg3 = "#859289";
    fg4 = "#7a8478";
    
    # Gray
    gray = "#859289";
    
    # Colors
    red = "#e67e80";
    green = "#a7c080";
    yellow = "#dbbc7f";
    blue = "#7fbbb3";
    purple = "#d699b6";
    aqua = "#83c092";
    orange = "#e69875";
    
    # Light variants
    light_red = "#e67e80";
    light_green = "#a7c080";
    light_yellow = "#dbbc7f";
    light_blue = "#7fbbb3";
    light_purple = "#d699b6";
    light_aqua = "#83c092";
    light_orange = "#e69875";
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