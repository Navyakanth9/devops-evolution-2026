#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "=== Beginning Enterprise Infrastructure Boot ==="
dnf update -y
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

# ------------------------------------------------------------
# THE CELEBRATION BLOCK: Creating Your Dynamic Web Dashboard
# ------------------------------------------------------------
# We are building a modern, dark-themed animated HTML page directly on the server
cat << 'HTML_EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps Evolution Matrix</title>
    <style>
        body {
            background-color: #0d1117;
            color: #58a6ff;
            font-family: 'Courier New', Courier, monospace;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .container {
            text-align: center;
            border: 2px solid #238636;
            padding: 40px;
            border-radius: 12px;
            background: rgba(22, 27, 34, 0.8);
            box-shadow: 0 0 30px rgba(35, 134, 54, 0.4);
            animation: pulse 2s infinite;
        }
        h1 {
            color: #39ff14; /* Neon Green */
            font-size: 3rem;
            margin-bottom: 10px;
            text-shadow: 0 0 10px #39ff14;
        }
        h2 {
            color: #ff007f; /* Neon Pink */
            font-size: 1.8rem;
            margin-bottom: 30px;
        }
        .badge {
            background-color: #238636;
            color: #ffffff;
            padding: 8px 16px;
            font-weight: bold;
            border-radius: 20px;
            display: inline-block;
            font-size: 1rem;
            letter-spacing: 2px;
            box-shadow: 0 0 10px #238636;
        }
        @keyframes pulse {
            0% { box-shadow: 0 0 20px rgba(35, 134, 54, 0.4); }
            50% { box-shadow: 0 0 40px rgba(57, 255, 20, 0.7); }
            100% { box-shadow: 0 0 20px rgba(35, 134, 54, 0.4); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>CONGRATULATIONS, NAVYAKANTH! 🚀</h1>
        <h2>Modular Web Server Successfully Deployed via Terraform</h2>
        <div class="badge">STATUS: PIPELINE EXECUTED SUCCESSFULLY</div>
    </div>
</body>
</html>
HTML_EOF

echo "=== System Boot Completed Cleanly ==="
