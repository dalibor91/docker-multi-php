<VirtualHost *:80>
    ServerName {{ server_name }}
    ServerAlias www.{{ server_name }}
    ServerAdmin admin@{{ server_name }}

    Alias /___error /var/www/html/error

    DocumentRoot {{ data['documentRoot'] }}
    <Directory {{ data['documentRoot'] }}>
        ErrorDocument 400 /___error/index.html
        ErrorDocument 401 /___error/index.html
        ErrorDocument 403 /___error/index.html
        ErrorDocument 404 /___error/index.html
        ErrorDocument 500 /___error/index.html
        ErrorDocument 502 /___error/index.html
        ErrorDocument 503 /___error/index.html

        Options FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    {% if 'authFile' in data %}
    <Directory {{ data['documentRoot'] }}>
        AuthType Basic
        AuthName "Restricted"
        AuthBasicProvider file
        AuthUserFile "{{ data['authFile'] }}"
        Require valid-user
    </Directory>
    {% endif %}

    LogLevel warn
    ErrorLog ${APACHE_LOG_DIR}/{{ server_name }}/error.log
    CustomLog ${APACHE_LOG_DIR}/{{ server_name }}/access.log combined
</VirtualHost>
