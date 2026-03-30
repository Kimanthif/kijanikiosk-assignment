# kk-payments Hardening Log

Starting systemd-analyze security score: 3.8

## Directives applied:
- ProtectSystem=strict → score: 3.0
- NoNewPrivileges=yes → score: 2.8
- PrivateTmp=yes → score: 2.6
- ReadOnlyPaths=/opt/kijanikiosk/config → score: 2.4

## Directives considered but not applied:
- RestrictNamespaces=yes → breaks network access, skipped
- SystemCallFilter=~@clock → prevented time sync, skipped

## Final score: 2.4

## Final unit file

[Unit]
Description=KijaniKiosk Payments Service
After=kk-api.service
Wants=kk-api.service

[Service]
User=kk-payments
Group=kijanikiosk
EnvironmentFile=/opt/kijanikiosk/config/payments-api.env
ExecStart=/opt/kijanikiosk/bin/kk-payments
ProtectSystem=strict
NoNewPrivileges=yes
PrivateTmp=yes
ReadOnlyPaths=/opt/kijanikiosk/config
Restart=on-failure

[Install]
WantedBy=multi-user.target