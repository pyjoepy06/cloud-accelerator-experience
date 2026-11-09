# Simple Source Web Servers

**Status: Prepared template; EC2 deployment and MGN replication are pending instructor testing.**

## Instructor source setup

1. Launch one dedicated EC2 source per student in the instructor's training account. Start with a standard Amazon Linux 2023 image and a small root disk; confirm the exact image/kernel is supported by MGN before rehearsal.
2. Use the [user-data script](web-server-user-data.sh). Set `LAB_LABEL` to a different synthetic student alias before each launch.
3. The instance needs repository access to install Apache. The script also works when run with sudo on a fresh compatible instance.
4. Restrict inbound TCP 80 to approved classroom/test sources, and use a restricted management path. The page contains no sensitive information. Do not open SSH broadly.
5. Validate `curl --fail http://127.0.0.1/` on the source and browse its reachable HTTP address. If installation fails, check `/var/log/cloud-init-output.log`.
6. Record the page label and `sha256sum /var/www/html/index.html /var/www/html/migration-check.txt` before replication.

The script installs Apache and writes a static HTML page plus a small validation file. It does not create EC2 instances, open security groups, configure IAM, or install MGN.

## Replicate into the student account

Use a separate source per student. Initialize/configure MGN in each target account and register its assigned source using that destination's authorized installer workflow. Confirm source registration in the correct account before continuing.

Validate HTTPS control-plane access and the required source-to-staging replication path, including TCP 1500. Cross-account IAM authorization alone does not establish network reachability. Confirm exact routing and endpoint requirements during rehearsal.

## Student validation

After a test launch into your account:

- Confirm the account ID, target Region, subnet, security groups, and target instance ID.
- Establish management access and confirm `systemctl is-active httpd`.
- Run `curl --fail http://127.0.0.1/` and `curl --fail http://127.0.0.1/migration-check.txt`.
- Browse the target's reachable HTTP address and confirm the original workload label.
- Compare both file checksums to the instructor's source evidence.

The page is intentionally copied unchanged. A matching label proves the expected content was migrated; console identity/networking evidence proves it is now running in your account. Internet browser access requires a suitable public address, IGW routing, and scoped HTTP rules; private targets require an approved private access path.

Do not reinstall the page on the target to hide a failed migration.

## Cleanup and costs

Each student owns cleanup in their destination account with instructor guidance. Remove temporary MGN replication resources through the service lifecycle, terminate test/cutover instances, and check volumes/snapshots and networking costs. The instructor separately removes source instances and source disks.

Do not finalize a cutover or decommission a source until validation and the classroom decision are complete. Rehearse cleanup before class.

[Back to demo](README.md)
