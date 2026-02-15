# 50-network.sh — optional networking helpers

# Tailscale IP helper (only if interface exists)
tail4() {
  /sbin/ip -o -4 addr show dev tailscale0 2>/dev/null | awk '{print $4}' | cut -d/ -f1
}
