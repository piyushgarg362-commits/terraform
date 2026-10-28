#!/bin/bash
set -eux
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y nginx
cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Jenkins project AWS Project</title>
</head>
<body>
<h1>Deployment Successful!</h1>
<p>This EC2 instance was provisioned using Terraform.</p>
<p>Automated deployment: GitHub + Jenkins + Terraform + AWS.</p>
</body>
</html>
HTML
systemctl enable nginx
systemctl restart nginx
