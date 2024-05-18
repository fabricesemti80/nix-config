{ lib }: rec {
  mainGateway = "10.0.20.1"; # main router
  # use suzi as the default gateway
  # it's a subrouter with a transparent proxy #TODO: in my setup gw = router
  defaultGateway = "10.0.20.1";
  nameservers = [
    "208.67.220.220" # OpenDNS 1
    "208.67.222.222" # OpenDNS 2
    "1.1.1.1" # Cloudflare
  ];
  prefixLength = 24;

  hostsAddr = {
    /* ---------------------------------------------------------------------------------------------- */
    /*                                          # PROXMOX VMS                                         */
    /* ---------------------------------------------------------------------------------------------- */
    magnus = {
      # VM
      iface = "ens18";
      ipv4 = "10.0.20.201";
    };
    fulgrim = {
      # VM
      iface = "ens18";
      ipv4 = "10.0.20.202";
    };
  };

  hostsInterface =
    lib.attrsets.mapAttrs
      (
        _key: val: {
          interfaces."${val.iface}" = {
            useDHCP = false;
            ipv4.addresses = [
              {
                inherit prefixLength;
                address = val.ipv4;
              }
            ];
          };
        }
      )
      hostsAddr;

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host ruby
    #     HostName 192.168.5.102
    #     Port 22
    #
    #   Host kana
    #     HostName 192.168.5.103
    #     Port 22
    #   ...
    # '';
    extraConfig =
      lib.attrsets.foldlAttrs
        (acc: host: val:
          acc
          + ''
            Host ${host}
              HostName ${val.ipv4}
              Port 22
          '')
        ""
        hostsAddr;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames = [ host hostsAddr.${host}.ipv4 ];
          publicKey = value.publicKey;
        })
        {
          #? https://nixos-and-flakes.thiscute.world/best-practices/remote-deployment#remote-deployment
          magnus.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJnzlnkmFirv33D+CuTu0wsk4JVUqZ4Rgk7ybU2hBnrS root@magnus";
          fulgrim.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETObXOI0LG+w5LilczO0eNLfzrWa6 + XGVJgliP9PBNc root@fulgrim";
        };
  };
}
