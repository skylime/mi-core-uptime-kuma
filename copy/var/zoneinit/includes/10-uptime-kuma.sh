#!/usr/bin/env bash

if [ ! -f "/var/db/kuma/kuma.db" ]; then
  cp /opt/kuma/db/kuma.db /var/db/kuma/kuma.db
fi

# Setup admin user if it does not exists
if KUMA_PASSWORD=$(/opt/core/bin/mdata-create-password.sh -m kuma_admin_initial_pw); then
    KUMA_PASSWORD_CRYPT=$(
        cd /opt/kuma/server \
            && node -e "pwd = require('./password-hash'); pwd.generate('${KUMA_PASSWORD}').then(result => console.log(result));"
    )
    sqlite3 /var/db/kuma/kuma.db "INSERT OR REPLACE INTO user (username, password,active) VALUES ('admin', '${KUMA_PASSWORD_CRYPT}', 1);"
fi

# Fix permissions
chown kuma:kuma /var/db/kuma/kuma.db

# Enable Uptime Kuma service to initial access the page
svcadm enable svc:/application/uptime-kuma:default
