{ config, lib, ... }:
let
  cfg = config.zfs-root.per-user.yc.modules.hiddenServices;
  inherit (lib) mkDefault mkOption types mkIf mkMerge;
in {
  options.zfs-root.per-user.yc.modules.hiddenServices = {
    enable = mkOption {
      type = types.bool;
      default = config.zfs-root.per-user.yc.enable;
    };
    resolv = mkOption {
      type = types.bool;
      default = config.zfs-root.per-user.yc.modules.hiddenServices.enable;
    };
  };
  config = mkIf (cfg.enable) (mkMerge [
    {
      services = {
        tor = {
          enable = mkDefault true;
          client = {
            enable = true;
            dns.enable = true;
          };
          settings = {
            Sandbox = true;
            SafeSocks = 1;
            NoExec = 1;
          };
          torsocks = {
            enable = true;
            server = "127.0.0.1:9050";
          };
        };
        i2pd = {
          enable = mkDefault true;
          enableIPv4 = true;
          enableIPv6 = true;
          bandwidth = 4096;
          port = 29392;
          proto = {
            http = {
              port = 7071;
              enable = true;
            };
            socksProxy.port = 4447;
            socksProxy.enable = true;
          };
          floodfill = true;
          inTunnels = { };
          outTunnels = {
            # connect to mail services by postman
            # available at http://hq.postman.i2p
            smtp-postman = {
              enable = true;
              address = "::1";
              destinationPort = 7659;
              destination = "smtp.postman.i2p";
              port = 7659;
            };
            pop-postman = {
              enable = true;
              address = "::1";
              destinationPort = 7660;
              destination = "pop.postman.i2p";
              port = 7660;
            };
          };
        };

        yggdrasil = {
          enable = true;
          openMulticastPort = false;
          settings.Peers = [
            #curl -o test.html https://publicpeers.neilalexander.dev/
            #grep -e 'tls://' -e 'tcp://' test.html  | grep -v offline | sed 's|<td id="address">|"|' | sed 's|</td><td.*|"|g' | wl-copy -n
            "tls://192.99.145.61:58226"
            "tls://[2607:5300:201:3100::50a1]:58226"
            "tcp://kusoneko.moe:9002"
            "tls://ca1.servers.devices.cwinfo.net:58226"
            "tls://[2a03:3b40:fe:ab::1]:993"
            "tls://37.205.14.171:993"
            "tcp://[2a05:9403::8b]:7743"
            "tcp://195.123.245.146:7743"
            "tls://65.21.57.122:61995"
            "tls://[2a01:4f9:c010:664d::1]:61995"
            "tls://95.216.5.243:18836"
            "tls://[2a01:4f9:2a:60c::2]:18836"
            "tls://aurora.devices.waren.io:18836"
            "tls://fi1.servers.devices.cwinfo.net:61995"
            "tcp://51.15.204.214:12345"
            "tls://152.228.216.112:23108"
            "tls://51.15.204.214:54321"
            "tls://[2001:41d0:304:200::ace3]:23108"
            "tls://[2001:41d0:303:13b3:51:255:223:60]:54232"
            "tls://51.255.223.60:54232"
            "tcp://62.210.85.80:39565"
            "tcp://s2.i2pd.xyz:39565"
            "tls://62.210.85.80:39575"
            "tls://fr2.servers.devices.cwinfo.net:23108"
            "tls://cloudberry.fr1.servers.devices.cwinfo.net:54232"
            "tls://s2.i2pd.xyz:39575"
            "tcp://193.107.20.230:7743"
            "tcp://ygg.yt:80"
            "tls://ygg.yt:443"
            "tcp://94.130.203.208:5999"
            "tcp://yggdrasil.su:62486"
            "tcp://ygg1.mk16.de:1337?key=0000000087ee9949eeab56bd430ee8f324cad55abf3993ed9b9be63ce693e18a"
            "tls://87.251.77.39:65535"
            "tcp://ygg.mkg20001.io:80"
            "tcp://ygg2.mk16.de:1337?key=000000d80a2d7b3126ea65c8c08fc751088c491a5cdd47eff11c86fa1e4644ae"
            "tcp://phrl42.ydns.eu:8842"
            "tls://vpn.ltha.de:443?key=0000006149970f245e6cec43664bce203f2514b60a153e194f31e2b229a1339d"
            "tls://ygg1.mk16.de:1338?key=0000000087ee9949eeab56bd430ee8f324cad55abf3993ed9b9be63ce693e18a"
            "tls://ygg2.mk16.de:1338?key=000000d80a2d7b3126ea65c8c08fc751088c491a5cdd47eff11c86fa1e4644ae"
            "tls://s-fra-0.sergeysedoy97.ru:65535"
            "tls://de-fsn-1.peer.v4.yggdrasil.chaz6.com:4444"
            "tls://x-fra-0.sergeysedoy97.ru:65535"
            "tls://ygg.mkg20001.io:443"
            "tls://yggdrasil.su:62586"
            "tcp://gutsche.tech:8888"
            "tls://gutsche.tech:8889"
            "tls://94.140.114.241:4708"
            "tls://[2a12:5940:1464::2]:65535"
            "tls://94.103.82.150:8080"
            "tls://89.22.237.91:65535"
            "tls://[2a0d:8480:1:f9::]:65535"
            "tls://23.137.249.65:443"
            "tls://45.147.198.155:6010"
            "tls://79.137.194.94:65535"
            "tcp://vpn.itrus.su:7991"
            "tls://s-ams-0.sergeysedoy97.ru:65535"
            "tls://x-ams-0.sergeysedoy97.ru:65535"
            "tls://s-ams-1.sergeysedoy97.ru:65535"
            "tls://x-ams-1.sergeysedoy97.ru:65535"
            "tls://54.37.137.221:11129"
            "tls://[2001:41d0:601:1100::cf2]:11129"
            "tls://pl1.servers.devices.cwinfo.net:11129"
            "tls://185.165.169.234:8443"
            "tcp://185.165.169.234:8880"
            "tls://[2a00:b700::c:2e1]:65535"
            "tls://s-mow-4.sergeysedoy97.ru:65535"
            "tls://[2a00:b700:5::5:34]:65535"
            "tls://[2a00:b700:3::3:3b4]:65535"
            "tls://x-mow-0.sergeysedoy97.ru:65535"
            "tls://x-mow-1.sergeysedoy97.ru:65535"
            "tls://s-mow-3.sergeysedoy97.ru:65535"
            "tls://s-led-0.sergeysedoy97.ru:65535"
            "tls://s-mow-0.sergeysedoy97.ru:65535"
            "tls://s-mow-1.sergeysedoy97.ru:65535"
            "tls://x-mow-3.sergeysedoy97.ru:65535"
            "tls://x-led-0.sergeysedoy97.ru:65535"
            "tls://s-mow-2.sergeysedoy97.ru:65535"
            "tls://x-mow-2.sergeysedoy97.ru:65535"
            "tls://x-mow-4.sergeysedoy97.ru:65535"
            "tls://[2a00:b700:4::3:6f]:65535"
            "tls://s-ovb-1.sergeysedoy97.ru:65535"
            "tls://[2a00:b700:2::5:2d4]:65535"
            "tls://s-ovb-0.sergeysedoy97.ru:65535"
            "tls://x-ovb-0.sergeysedoy97.ru:65535"
            "tls://x-ovb-1.sergeysedoy97.ru:65535"
            "tcp://45.95.202.21:12403"
            "tcp://[2a09:5302:ffff::992]:12403"
            "tls://45.95.202.21:443"
            "tls://[2a09:5302:ffff::992]:443"
            "tls://45.95.202.91:65535"
            "tls://x-kzn-0.sergeysedoy97.ru:65535"
            "tls://[2a09:5302:ffff::aca]:65535"
            "tls://[2a00:b700:1::38]:65535"
            "tls://185.103.109.63:65535"
            "tls://[2a09:5302:ffff::ac9]:65535"
            "tcp://antebeot.ru:7890"
            "tls://antebeot.ru:7891"
            "tls://[2a0d:8480:2:54::]:65535"
            "tls://178.20.45.32:65535"
            "tcp://188.225.9.167:18226"
            "tcp://yggno.de:18226"
            "tcp://box.paulll.cc:13337"
            "tcp://92.124.136.131:30111"
            "tls://box.paulll.cc:13338"
            "tcp://srv.itrus.su:7991"
            "tls://[2a00:b700::a:279]:443"
            "tls://yggno.de:18227"
            "tcp://itcom.multed.com:7991"
            "tls://188.225.9.167:18227"
            "tls://avevad.com:1337"
            "tcp://ekb.itrus.su:7991"
            "tls://158.101.229.219:17001"
            "tcp://158.101.229.219:17002"
            "tcp://[2603:c023:8001:1600:35e0:acde:2c6e:b27f]:17002"
            "tls://[2603:c023:8001:1600:35e0:acde:2c6e:b27f]:17001"
            "tcp://sin.yuetau.net:6642"
            "tls://sin.yuetau.net:6643"
            "tcp://y.zbin.eu:7743"
            "tcp://yggdrasil.community.garage.networks.deavmi.assigned.network:2000"
            "tls://yggdrasil.community.garage.networks.deavmi.assigned.network:2001"
            "tls://77.91.84.76:65535"
            "tls://x-sto-0.sergeysedoy97.ru:65535"
            "tls://s-sto-0.sergeysedoy97.ru:65535"
            "tcp://80.78.27.103:30111"
            "tls://[2a12:5940:b1a0::2]:65535"
            "tls://185.130.44.194:7040"
            "tls://[2a07:e01:105:444:c634:6bff:feb5:6e28]:7040"
            "tcp://zhoskiy.xyz:30111"
            "tcp://ygg.ace.ctrl-c.liu.se:9998?key=5636b3af4738c3998284c4805d91209cab38921159c66a6f359f3f692af1c908"
            "tls://ygg.ace.ctrl-c.liu.se:9999?key=5636b3af4738c3998284c4805d91209cab38921159c66a6f359f3f692af1c908"
            "tcp://193.111.114.28:8080"
            "tls://193.111.114.28:1443"
            "tcp://78.27.153.163:33165"
            "tls://78.27.153.163:179"
            "tls://78.27.153.163:3784"
            "tls://78.27.153.163:3785"
            "tls://78.27.153.163:33166"
            "tls://185.175.90.87:43006"
            "tls://[2a10:4740:40:0:2222:3f9c:b7cf:1]:43006"
            "tls://51.38.64.12:28395"
            "tcp://0.ygg.l1qu1d.net:11100?key=0000000998b5ff8c0f1115ce9212f772d0427151f50fe858e6de1d22600f1680"
            "tls://[2001:41d0:801:2000::233f]:28395"
            "tcp://curiosity.tdjs.tech:30003"
            "tls://uk1.servers.devices.cwinfo.net:28395"
            "tls://0.ygg.l1qu1d.net:11101?key=0000000998b5ff8c0f1115ce9212f772d0427151f50fe858e6de1d22600f1680"
            "tls://108.175.10.127:61216"
            "tls://102.223.180.74:993"
            "tls://[2605:9f80:2000:64::2]:7040"
            "tls://167.160.89.98:7040"
            "tls://ygg.mnpnk.com:443"
            "tls://ygg.jjolly.dev:3443"
            "tcp://lancis.iscute.moe:49273"
            "tcp://supergay.network:9002"
            "tcp://cowboy.supergay.network:9111"
            "tcp://longseason.1200bps.xyz:13121"
            "tcp://ygg4.mk16.de:1337?key=0000147df8daa1cce2ad4b1d4b14c60a4c69a991b2dfde4e00ba7e95c36c530b"
            "tls://longseason.1200bps.xyz:13122"
            "tcp://zabugor.itrus.su:7991"
            "tls://lancis.iscute.moe:49274"
            "tls://ygg4.mk16.de:1338?key=0000147df8daa1cce2ad4b1d4b14c60a4c69a991b2dfde4e00ba7e95c36c530b"
            "tls://supergay.network:9001"
            "tcp://ygg3.mk16.de:1337?key=000003acdaf2a60e8de2f63c3e63b7e911d02380934f09ee5c83acb758f470c1"
            "tls://supergay.network:443"
            "tls://cowboy.supergay.network:443"
            "tcp://corn.chowder.land:9002"
            "tls://corn.chowder.land:443"
            "tls://ygg3.mk16.de:1338?key=000003acdaf2a60e8de2f63c3e63b7e911d02380934f09ee5c83acb758f470c1"
            "tls://44.234.134.124:443"
          ];
        };

      };
      networking.hosts = {
        "200:8bcd:55f4:becc:4d85:2fa6:2ed2:5eba" = [ "tl.yc" ];
      };
    }
    (mkIf cfg.resolv {
      networking.nameservers = [ "::1" ];
      services.dnscrypt-proxy2 = {
        enable = true;
        settings = {
          listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
          max_clients = 250;
          # https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
          server_names = [
            "dns0"
            "scaleway-fr"
            "google"
            "google-ipv6"
            "cloudflare"
            "dct-de1"
            "dns.digitalsize.net"
            "dns.digitalsize.net-ipv6"
            "dns.watch"
            "dns.watch-ipv6"
            "dnscrypt-de-blahdns-ipv4"
            "dnscrypt-de-blahdns-ipv6"
            "doh.ffmuc.net"
            "doh.ffmuc.net-v6"
            "he"
            "dnsforge.de"
            "bortzmeyer"
            "bortzmeyer-ipv6"
            "circl-doh"
            "circl-doh-ipv6"
            "cloudflare-ipv6"
            "dns.digitale-gesellschaft.ch-ipv6"
            "dns.digitale-gesellschaft.ch"
          ];
          ipv4_servers = true;
          ipv6_servers = false;
          dnscrypt_servers = true;
          doh_servers = true;
          odoh_servers = false;
          require_dnssec = false;
          require_nolog = true;
          require_nofilter = true;
          disabled_server_names = [ ];
          force_tcp = false;
          http3 = false;
          timeout = 5000;
          keepalive = 30;
          cert_refresh_delay = 240;
          bootstrap_resolvers = [ "9.9.9.11:53" "8.8.8.8:53" ];
          ignore_system_dns = true;
          netprobe_timeout = 60;
          netprobe_address = "9.9.9.9:53";
          log_files_max_size = 10;
          log_files_max_age = 7;
          log_files_max_backups = 1;
          block_ipv6 = false;
          block_unqualified = true;
          block_undelegated = true;
          reject_ttl = 10;
          cache = true;
          cache_size = 4096;
          cache_min_ttl = 2400;
          cache_max_ttl = 86400;
          cache_neg_min_ttl = 60;
          cache_neg_max_ttl = 600;
          sources.public-resolvers = {
            urls = [
              "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md"
              "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
            ];
            cache_file = "public-resolvers.md";
            minisign_key =
              "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            refresh_delay = 72;
          };
          sources.relays = {
            urls = [
              "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
              "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
            ];
            cache_file = "relays.md";
            minisign_key =
              "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            refresh_delay = 72;
          };
          query_log.file = "query.log";
          query_log.format = "tsv";
          anonymized_dns.skip_incompatible = false;
          broken_implementations.fragments_blocked = [
            "cisco"
            "cisco-ipv6"
            "cisco-familyshield"
            "cisco-familyshield-ipv6"
            "cleanbrowsing-adult"
            "cleanbrowsing-adult-ipv6"
            "cleanbrowsing-family"
            "cleanbrowsing-family-ipv6"
            "cleanbrowsing-security"
            "cleanbrowsing-security-ipv6"
          ];
        };
        upstreamDefaults = false;
      };
    })

  ]);
}
