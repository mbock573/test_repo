 { pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   time.timeZone = "Europe/Berlin";
   i18n.defaultLocale = "de_DE.UTF-8";
   console.keyMap = "de";
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     mbock = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
         ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGdW3EGyX5Rc6oFl39RGhPQJRCSq1etCv8ntIxMgmhWiRTOIgaLsxSDivVqhSOAcRyMhp7eshwOCk+Lr/JycqtmxFzrDtYubSQDB8EQlJw44txrTYHyrMBzW3khn8RrDO3fGZqpVunyaefggMJsqi+Iz2DqLi6bp8bWmRXmEV9gt+sj/eZ/nlNvR6i+kNeVApAfnd5/2aeDSShoVYKFYI3G7X0cb3+IVAIwcYHTi9amK0jW/jacVPJN5A2yXNusUwNpJl2gWh3b90RAU809Eb3l3cc0q43miCqEFnIVIXog4hnco4BdMTcoJLvVw7+pJ5YY40DgPeZk6pXXqlbFJCBELBRMlazhGA8VKpu8siSkXY3l295IhQivPaUwUd7X5ObfvA6MnelkQ4Bj6TkS+J4lbP6yBY5kuwaJ7Zx4KyHkM42HQH3+eEsAIDgilOJttgDR9Lm3hoBe9j9jnZAesHU0Vs6WYv1WOUQTkDclwyRKcGgVBFppK/vV6cNWtuRYzK3blBHogUapMfjI/y+qMQ4b5S2ru/rmg+z6Gx8olHNS4Kt6doD28Zf6hXTJpR7w5Akm3BcqlMaI0T1ExcTd/FLR4Zemni7im4G1VMJ0g2vQ7Kq7+V1SjtOEhFyZUC4mytqTSRaARyiTc8Ymh/NC8xO8dBelavFLktLzTqoJ9LX5w== "mbock@hp_elitebook"
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };
   
   networking.firewall.allowedTCPPorts = [ 22 ];
   
   system.stateVersion = "24.11";
 }