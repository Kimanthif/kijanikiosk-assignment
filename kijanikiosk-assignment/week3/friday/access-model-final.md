# KijaniKiosk Access Model (Final)

## Users and Groups
- kk-api: service account for API
- kk-payments: service account for payments
- kk-logs: service account for logging
- kijanikiosk: parent group owning shared resources

## Directory Permissions

| Directory                         | Owner:Group        | Permissions | ACL Notes |
|----------------------------------|------------------|------------|-----------|
| /opt/kijanikiosk/                 | root:kijanikiosk  | 750        | -         |
| /opt/kijanikiosk/shared/logs/     | kk-logs:kijanikiosk | 770      | Default ACLs for kk-api, kk-payments |
| /opt/kijanikiosk/config/          | root:kijanikiosk  | 640        | kk-api and kk-payments can read |
| /opt/kijanikiosk/health/          | kk-logs:kijanikiosk | 640      | Health check JSON readable by kijanikiosk group |

## Notes
- ACLs are used to ensure only intended service accounts have read/write access.
- Logrotate preserves ACLs after rotation using `create mask` configuration.
- Health check JSON file is readable by all services in the `kijanikiosk` group.