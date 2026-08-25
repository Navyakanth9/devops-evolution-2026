#!/bin/bash
dnf update -y
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

cat << 'EOF' > /var/www/html/index.html #This defines the content of the index.html file that will be served by the Apache web server. The content is a simple HTML page with a purple background and white text, indicating that this is a "PURPLE DEPLOYMENT (v2)" and that the code has changed dynamically. The EOF marker indicates the end of the content being written to the index.html file.
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
