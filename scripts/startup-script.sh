#!/bin/bash

# Update packages
apt update -y

# Install Apache and PHP
apt install -y apache2 php libapache2-mod-php

# Enable Apache to start on boot
systemctl enable apache2
systemctl start apache2

# Remove default Apache page if exists
rm -f /var/www/html/index.html

# Ensure Apache prioritizes index.php
sed -i 's/DirectoryIndex .*/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf

# Create your custom index.php
cat <<'EOF' > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
    <title>VCC Assignment 2</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            width: 500px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        h1 {
            text-align: center;
            color: #1e3c72;
        }
        h2 {
            color: #2a5298;
            margin-top: 20px;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin: 6px 0;
        }
        .footer {
            text-align: center;
            margin-top: 15px;
            font-size: 13px;
            color: gray;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>VCC Assignment 2</h1>
        <p style="text-align:center;"><b>GCP: Create a VM to Leverage Auto Scaling and Security</b></p>

        <h2>Student Details</h2>
        <ul>
            <li><b>Name:</b> Shrusti Jain</li>
            <li><b>Roll No:</b> M25CSE030</li>
        </ul>

        <h2>Instance Details</h2>
        <ul>
            <li><b>Hostname:</b> <?php echo gethostname(); ?></li>
            <li><b>Internal IP:</b> <?php echo $_SERVER['SERVER_ADDR']; ?></li>
            <li><b>Zone:</b> asia-south1-a</li>
            <li><b>Current Time:</b> <?php echo date('Y-m-d H:i:s'); ?></li>
        </ul>

        <h2>Cloud Configuration</h2>
        <ul>
            <li>Managed Instance Group</li>
            <li>CPU-based Auto Scaling</li>
            <li>IAM Role Restriction</li>
            <li>Firewall Configured</li>
        </ul>

        <div class="footer">
            Google Cloud Platform Implementation
        </div>
    </div>
</body>
</html>
EOF

# Set proper permissions
chown www-data:www-data /var/www/html/index.php
chmod 644 /var/www/html/index.php

# Restart Apache
systemctl restart apache2