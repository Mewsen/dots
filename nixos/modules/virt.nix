{pkgs, ...}:

{
   virtualisation.libvirtd.enable = true;
   virtualisation.docker.enable = true;

   environment.systemPackages = with pkgs; [
   	virt-manager
	docker-compose
   ];
}
