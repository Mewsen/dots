{pkgs, ...}:

{
   virtualisation.libvirtd.enable = true;
   virtualisation.docker.enable = true;
   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableKvm = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;
   virtualisation.virtualbox.host.enableHardening = false;
   virtualisation.virtualbox.host.addNetworkInterface = false;


   environment.systemPackages = with pkgs; [
   	virt-manager
	docker-compose
   ];
}
