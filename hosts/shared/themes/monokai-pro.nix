{
  name = "monokai-pro";
  
  colors = {
    # Background colors (authentic Monokai Pro palette)
    bg0 = "#19181a";      # Dark background
    bg1 = "#221f22";      # Black background  
    bg2 = "#403e41";      # Dimmed5
    bg3 = "#5b595c";      # Dimmed4
    bg4 = "#727072";      # Dimmed3
    bg5 = "#939293";      # Dimmed2
    
    # Foreground colors
    fg = "#fcfcfa";       # White
    
    # Gray variations
    gray0 = "#727072";    # Dimmed3
    gray1 = "#939293";    # Dimmed2
    gray2 = "#c1c0c0";    # Dimmed1
    
    # Primary colors (authentic Monokai Pro)
    red = "#ff6188";
    orange = "#fc9867";   # Blue in original palette
    yellow = "#ffd866";
    green = "#a9dc76";
    aqua = "#78dce8";     # Cyan
    blue = "#ab9df2";     # Magenta
    purple = "#ab9df2";   # Magenta
    pink = "#ff6188";     # Red
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