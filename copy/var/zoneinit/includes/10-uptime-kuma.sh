#!/usr/bin/env bash
#

# Enable Uptime Kuma service to initial access the page
svcadm enable svc:/application/uptime-kuma:default

# Initial access the page to create the database file if it doesn't exists.
# Only required for the first setup but will not break anything if it run
# on provision anyway.
log "waiting for the uptime-kuma to show up"
COUNT="0"
while ! curl -q "http://localhost:3001" > /dev/null 2>&1; do
    sleep 1
    ((COUNT = COUNT + 1))
    if [[ $COUNT -eq 60 ]]; then
        log "ERROR Could not talk to uptime-kuma after 60 seconds"
        ERROR=yes
        break 1
    fi
done
[[ -n "${ERROR}" ]] && exit 31
log "(it took ${COUNT} seconds to start properly)"

# Setup admin user if it does not exists
if KUMA_PASSWORD=$(/opt/core/bin/mdata-create-password.sh -m kuma_admin_initial_pw); then
    KUMA_PASSWORD_CRYPT=$(
        cd /opt/kuma/server \
            && node -e "pwd = require('./password-hash'); console.log(pwd.generate('${KUMA_PASSWORD}'))"
    )
    sqlite3 /var/db/kuma/kuma.db "INSERT OR REPLACE INTO user (username, password,active) VALUES ('admin', '${KUMA_PASSWORD_CRYPT}', 1);"
fi
