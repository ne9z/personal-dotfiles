{ system, pkgs, ... }: {
  inherit pkgs system;
  zfs-root = {
    boot = {
      bootDevices = [
        "ata-WDC_WD20EJRX-89G3VY0_WD-WCC4M0ZH64T7"
        "ata-WDC_WD20EJRX-89G3VY0_WD-WCC4M6ZPTJ7X"
        "ata-WDC_WD20EJRX-89G3VY0_WD-WCC4M4SUXL4D"
        "ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M1455922"
      ];
    };
    networking = {
      hostName = "tieling";
      hostId = "38bdc3d4";
    };
    per-user.yc.templates.server.enable = true;
    networking.timeZone = "Asia/Shanghai";
  };
}
