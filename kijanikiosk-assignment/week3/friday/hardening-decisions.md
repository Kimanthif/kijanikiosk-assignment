# KijaniKiosk Hardening Decisions

During Week 3 Friday, the server was configured to reduce the risk of unauthorized access, service compromise, and accidental data exposure. Each measure ensures predictable operation while protecting critical assets.

## Security Controls Table

| Control                     | What it does                                   | Risk mitigated                     |
|------------------------------|-----------------------------------------------|-----------------------------------|
| ProtectSystem=strict         | Makes system directories read-only           | Prevents accidental system changes|
| NoNewPrivileges=yes          | Prevents privilege escalation in service     | Limits impact of a compromised process|
| PrivateTmp=yes               | Isolates temporary files per service         | Prevents cross-service data leaks|
| ReadOnlyPaths=/config        | Config files cannot be changed by service    | Protects sensitive configs        |
| ACLs on shared logs          | Enforces who can read/write logs             | Maintains log integrity           |
| Systemd restart policies     | Auto-restarts failed services                | Reduces downtime                   |
| Firewall rules               | Only allows necessary traffic                 | Reduces attack surface             |
| Logrotate postrotate         | Ensures services can write to new log files | Maintains operational logging     |

## Honest gaps
- No data-at-rest encryption implemented.
- Privileged insider actions are not fully restricted.
- Some third-party package versions are pinned for stability rather than security.

## Summary
These measures create a layered security model while ensuring services run reliably. Future improvements would include encryption at rest and enhanced monitoring.