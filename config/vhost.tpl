<VirtualHost *:80>
    ServerName {{ server_name }}
    ServerAlias www.{{ server_name }}
    ServerAdmin admin@{{ server_name }}

    DocumentRoot {{ data['documentRoot'] }}
    <Directory {{ data['documentRoot'] }}>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    LogLevel warn
    ErrorLog ${APACHE_LOG_DIR}/{{ server_name }}/error.log
    CustomLog ${APACHE_LOG_DIR}/{{ server_name }}/access.log combined
</VirtualHost>
