#!/usr/bin/env bash
# This script will try to manage the ssl certificates for us, we support
# own ssl certificates, let's encrypt and selfsigned fallbacks for dev
# usage

# Request and manage SSL certificates
/opt/core/bin/ssl-generator.sh /opt/local/etc/nginx/ssl nginx_ssl nginx svc:/pkgsrc/nginx:default
