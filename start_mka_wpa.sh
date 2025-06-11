#!/bin/bash

# Netzwerkschnittstelle – bei Bedarf anpassen
IFACE="eth0"
MACSEC_IF="macsec_${IFACE}"

# IP-Adresse dieses Hosts (je nach Pi unterschiedlich setzen!)
LOCAL_IP="192.168.10.1/24"

# Pfad zur wpa_supplicant-Konfiguration
CONF="/etc/wpa_supplicant/wpa_supplicant.conf"

# Log-Datei (optional)
LOG="/var/log/wpa_macsec.log"

echo "[+] Stoppe alte Instanzen von wpa_supplicant..."
sudo pkill -f "wpa_supplicant -i ${IFACE}"

echo "[+] Starte wpa_supplicant mit MACsec MKA..."
sudo wpa_supplicant -i "$IFACE" -D wired -c "$CONF" -f "$LOG" -B

# Warten bis MACsec-Interface erscheint
echo "[+] Warte auf MACsec-Interface ($MACSEC_IF)..."
for i in {1..10}; do
    if ip link show "$MACSEC_IF" > /dev/null 2>&1; then
        echo "[+] MACsec-Interface erkannt: $MACSEC_IF"
        break
    fi
    sleep 1
done

# Prüfen ob Interface da ist
if ! ip link show "$MACSEC_IF" > /dev/null 2>&1; then
    echo "[!] Fehler: MACsec-Interface wurde nicht erstellt."
    exit 1
fi

# IP-Adresse setzen und Interface aktivieren
echo "[+] Setze IP-Adresse $LOCAL_IP auf $MACSEC_IF"
sudo ip addr flush dev "$MACSEC_IF"
sudo ip addr add "$LOCAL_IP" dev "$MACSEC_IF"
sudo ip link set dev "$MACSEC_IF" up

echo "[+] Fertig. Du kannst nun z. B. ping verwenden, um den anderen Pi zu erreichen."
