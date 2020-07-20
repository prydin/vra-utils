#!/bin/sh
apt install telegraf
cat /etc/telegraf/telegraf.d/10-wavefront.conf << EOF
[[outputs.wavefront]]
  token = "$TOKEN"
  url = "$URL"
  metric_separator = "."
  source_override = ["hostname", "agent_host", "node_host"]
  convert_paths = true
EOF
systemctl restart telegraf