conf file in /etc/wpa_supplicant/ Folder

than start in Folder:
sudo wpa_supplicant -i eth0 -D macsec_linux -c /etc/wpa_supplicant/macsec_psk_wpa.conf -dd

do this on both Pi`s, than wpa_supplicant mka handles the SAK. Take a look with wireshark on one of the Pi`s to control.
