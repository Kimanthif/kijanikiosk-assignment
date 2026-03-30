# Integration Notes

1. **ProtectSystem and EnvironmentFile**
   - Conflict: ProtectSystem=strict made /etc/config read-only
   - Resolution: Moved payments config to /opt/kijanikiosk/config and allowed read via ReadOnlyPaths

2. **Health check ACLs**
   - Conflict: Health check directory did not exist, root-owned
   - Resolution: Created /opt/kijanikiosk/health/, owned by kk-logs:kijanikiosk, permissions 640, ACLs allow group read

3. **Logrotate and PrivateTmp**
   - Conflict: Logrotate postrotate reload failed due to PrivateTmp
   - Resolution: Verified service does not require reload; skipped ExecReload, used touch test to confirm

4. **Dirty VM and package holds**
   - Conflict: Packages may be upgraded manually
   - Resolution: Script checks installed version before install; downgrades if necessary