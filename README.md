conf file in /etc/wpa_supplicant/ Folder

than start in Folder:
``sudo wpa_supplicant -i eth0 -D macsec_linux -c /etc/wpa_supplicant/macsec_psk_wpa.conf -dd``

do this on both Pis, than wpa_supplicant mka handles the SAK. Take a look with wireshark on one of the Pis to control.`

To Ping the virtual macsec0 interface needs a IP-Address:
``sudo ip addr add 192.168.10.2/24 dev macsec0`` / ``sudo ip addr add 192.168.10.3/24 dev macsec0``

Than:
``ping 192.168.10.2``
