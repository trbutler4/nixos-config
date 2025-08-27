{
  # Import theme modules
  gruvbox = import ./gruvbox.nix;
  everforest = import ./everforest.nix;
  monokai-pro = import ./monokai-pro.nix;
  
  # Theme selection - change this to switch themes globally
  current = "monokai-pro";
}
