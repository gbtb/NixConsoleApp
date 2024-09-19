{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
  };

  outputs = { self, nixpkgs }: 
    let pkgs = nixpkgs.legacyPackages.x86_64-linux; in
    {
    packages.x86_64-linux.hello = pkgs.buildDotnetModule {
      pname = "hello";
      version = "0.0.1";
      src = ./. ;
      nugetDeps = ./deps.nix;
      dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;

      projectFile = "ConsoleApp.csproj";
      executables = [ "ConsoleApp" ];

      meta = with pkgs.lib; {
        description = "test";
        mainProgram = "ConsoleApp";
        license = licenses.mit;
        platforms = [ "x86_64-linux" ];
        maintainers = with maintainers; [ gbtb ];
      };
      };

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
