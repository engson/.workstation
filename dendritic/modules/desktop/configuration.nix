
{
  inputs,
  ...
  
}:
{
  flake.modules.nixos.desktop = {
    import = with inputs.self.modules.nixops; [
      # what to import here?
    ];
  };
}
