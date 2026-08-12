#!/bin/bash
dnf update -y
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Infrastructure Test v2</title>
    <style>
        body { background-color: #4c1d95; color: #ffffff; font-family: sans-serif; text-align: center; padding-top: 20vh; }
        h1 { font-size: 3rem; }
    </style>
</head>
<body>
    <h1>🟣 PURPLE DEPLOYMENT (v2)</h1>
    <h2>The Code Changed dynamically!</h2>
</body>
</html>
EOF
