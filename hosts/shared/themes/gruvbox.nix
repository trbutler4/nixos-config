{
  name = "gruvbox";
  
  colors = {
    # Background colors
    bg0_hard = "#1d2021";
    bg0_normal = "#282828";
    bg0_soft = "#32302f";
    bg1 = "#3c3836";
    bg2 = "#504945";
    bg3 = "#665c54";
    bg4 = "#7c6f64";
    
    # Foreground colors
    fg = "#ebdbb2";  # Primary foreground (same as fg1)
    fg0 = "#fbf1c7";
    fg1 = "#ebdbb2";
    fg2 = "#d5c4a1";
    fg3 = "#bdae93";
    fg4 = "#a89984";
    
    # Gray
    gray = "#928374";
    
    # Colors
    red = "#cc241d";
    green = "#98971a";
    yellow = "#d79921";
    blue = "#458588";
    purple = "#b16286";
    aqua = "#689d6a";
    orange = "#d65d0e";
    
    # Light variants
    light_red = "#fb4934";
    light_green = "#b8bb26";
    light_yellow = "#fabd2f";
    light_blue = "#83a598";
    light_purple = "#d3869b";
    light_aqua = "#8ec07c";
    light_orange = "#fe8019";
  };
  
  # Application-specific theme configurations
  zellij = {
    theme_name = "gruvbox-dark";
    fg = "#ebdbb2";
    bg = "#282828";
    black = "#282828";
    red = "#cc241d";
    green = "#98971a";
    yellow = "#d79921";
    blue = "#458588";
    magenta = "#b16286";
    cyan = "#689d6a";
    white = "#a89984";
    orange = "#d65d0e";
  };
  
  waybar = {
    background = "rgba(40, 40, 40, 0.9)";
    foreground = "#ebdbb2";
    border = "rgba(102, 92, 84, 0.3)";
    workspace_active = "rgba(131, 165, 152, 0.8)";
    workspace_visible = "rgba(102, 92, 84, 0.6)";
    workspace_inactive = "rgba(168, 153, 132, 0.6)";
    warning = "#fabd2f";
    critical = "#fb4934";
    charging = "#b8bb26";
    power_button = "#fb4934";
    power_button_hover = "#cc241d";
  };
  
  wofi = {
    window_bg = "#282828";
    window_border = "#504945";
    input_bg = "#3c3836";
    input_fg = "#ebdbb2";
    text_fg = "#ebdbb2";
    entry_selected_bg = "#83a598";
    entry_selected_fg = "#1d2021";
  };
  
  nvf = {
    name = "gruvbox";
    style = "dark";
  };
  
  helix = {
    name = "gruvbox-dark-hard-transparent";
  };
  
  zed = {
    dark = "Gruvbox Dark Hard";
  };
  
  neovim = {
    colorscheme = "gruvbox";
  };
  
  alacritty = {
    colors = {
      primary = {
        background = "#1d2021";
        foreground = "#ebdbb2";
        bright_foreground = "#fbf1c7";
      };
      
      normal = {
        black = "#282828";
        red = "#cc241d";
        green = "#98971a";
        yellow = "#d79921";
        blue = "#458588";
        magenta = "#b16286";
        cyan = "#689d6a";
        white = "#a89984";
      };
      
      bright = {
        black = "#928374";
        red = "#fb4934";
        green = "#b8bb26";
        yellow = "#fabd2f";
        blue = "#83a598";
        magenta = "#d3869b";
        cyan = "#8ec07c";
        white = "#ebdbb2";
      };
      
      selection = {
        text = "#1d2021";
        background = "#ebdbb2";
      };
    };
  };
}