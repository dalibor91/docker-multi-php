<VirtualHost *:80>
    ServerName {{ server_name }}
    ServerAlias www.{{ server_name }}
    ServerAdmin admin@{{ server_name }}

    DocumentRoot {{ data['documentRoot'] }}
    <Directory {{ data['documentRoot'] }}>
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
