{
  name = "monokai-pro";
  
  colors = {
    # Background colors
    bg0_hard = "#19181a";
    bg0_normal = "#221f22";
    bg0_soft = "#2d2a2e";
    bg1 = "#221f22";
    bg2 = "#403e41";
    bg3 = "#5b595c";
    bg4 = "#727072";
    
    # Foreground colors
    fg = "#fcfcfa";
    fg0 = "#fcfcfa";
    fg1 = "#fcfcfa";
    fg2 = "#c1c0c0";
    fg3 = "#939293";
    fg4 = "#727072";
    
    # Gray
    gray = "#939293";
    
    # Colors
    red = "#ff6188";
    green = "#a9dc76";
    yellow = "#ffd866";
    blue = "#ab9df2";
    purple = "#ab9df2";
    aqua = "#78dce8";
    orange = "#fc9867";
    
    # Light variants
    light_red = "#ff6188";
    light_green = "#a9dc76";
    light_yellow = "#ffd866";
    light_blue = "#ab9df2";
    light_purple = "#ab9df2";
    light_aqua = "#78dce8";
    light_orange = "#fc9867";
  };
  
  # Application-specific theme configurations
  zellij = {
    theme_name = "monokai-pro";
    fg = "#fcfcfa";       # shade7
    bg = "#2c292d";       # shade0
    black = "#4a474a";    # shade1
    red = "#ff6188";      # accent3
    green = "#ffd866";    # accent1 (changed to yellow)
    yellow = "#ffd866";   # accent1
    blue = "#ab9df2";     # accent2
    magenta = "#ab9df2";  # accent2
    cyan = "#78dce8";     # accent4
    white = "#c1c0bf";    # shade5
    orange = "#fc9867";   # accent5
  };
  
  waybar = {
    background = "rgba(25, 24, 26, 0.9)";
    foreground = "#fcfcfa";
    border = "rgba(91, 89, 92, 0.3)";
    workspace_active = "rgba(169, 220, 118, 0.8)";
    workspace_visible = "rgba(114, 112, 114, 0.6)";
    workspace_inactive = "rgba(193, 192, 192, 0.6)";
    warning = "#ffd866";
    critical = "#ff6188";
    charging = "#a9dc76";
    power_button = "#ff6188";
    power_button_hover = "#ff6188";
  };
  
  wofi = {
    window_bg = "#19181a";
    window_border = "#5b595c";
    input_bg = "#403e41";
    input_fg = "#fcfcfa";
    text_fg = "#fcfcfa";
    entry_selected_bg = "#ab9df2";
    entry_selected_fg = "#19181a";
  };
  
  nvf = {
    name = "monokai-pro";
    style = "dark";
  };
  
  helix = {
    name = "monokai_pro";
  };
  
  zed = {
    dark = "Monokai Pro";
  };
  
  neovim = {
    colorscheme = "monokai-pro";
  };
  
  alacritty = {
    colors = {
      primary = {
        background = "#19181a";
        foreground = "#fcfcfa";
        bright_foreground = "#fcfcfa";
      };
      
      normal = {
        black = "#221f22";
        red = "#ff6188";
        green = "#a9dc76";
        yellow = "#ffd866";
        blue = "#ab9df2";
        magenta = "#ab9df2";
        cyan = "#78dce8";
        white = "#c1c0c0";
      };
      
      bright = {
        black = "#727072";
        red = "#ff6188";
        green = "#a9dc76";
        yellow = "#ffd866";
        blue = "#ab9df2";
        magenta = "#ab9df2";
        cyan = "#78dce8";
        white = "#fcfcfa";
      };
      
      selection = {
        text = "#19181a";
        background = "#fcfcfa";
      };
    };
  };
}