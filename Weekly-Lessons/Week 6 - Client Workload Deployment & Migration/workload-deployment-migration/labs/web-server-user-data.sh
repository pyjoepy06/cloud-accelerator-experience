#!/bin/bash
# Amazon Linux 2023 EC2 user data. Set a synthetic label for each source.
set -euo pipefail
LAB_LABEL="student-01-source"
dnf install -y httpd
install -d -m 755 /var/www/html
cat > /var/www/html/index.html <<HTML
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Cloud Accelerator Migration Lab</title>
<style>body{font-family:Arial,sans-serif;background:#101827;color:#fff;max-width:720px;margin:10vh auto;padding:24px}h1{color:#f4c35a}.card{background:#1e293b;padding:24px;border-radius:12px}</style></head>
<body><main class="card"><h1>Cloud Accelerator Migration Lab</h1>
<p>This web server is ready for our migration exercise.</p>
<p><strong>Workload label:</strong> ${LAB_LABEL}</p>
<p>This is synthetic training content. After migration, verify this same page in your student AWS account.</p>
<p>Think like an Architect, build like an Engineer, communicate with confidence.</p>
</main></body></html>
HTML
printf 'migration-demo-v1\n' > /var/www/html/migration-check.txt
chmod 644 /var/www/html/index.html /var/www/html/migration-check.txt
systemctl enable --now httpd
curl --fail --silent http://127.0.0.1/ >/dev/null
