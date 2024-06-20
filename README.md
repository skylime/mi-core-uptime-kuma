# mi-core-uptime-kuma

This repository is based on [Joyent mibe](https://github.com/joyent/mibe). Please note this repository should be build with the [mi-core-base](https://github.com/skylime/mi-core-base) mibe image.

## description

Image for [Uptime Kuma](https://github.com/louislam/uptime-kuma). A simple tool to monitor website uptime and status.

## mdata variables

- `kuma_admin_initial_pw`: initial password for admin user
- `nginx_ssl`: ssl cert, key and CA for nginx in pem format (if not provided Let's Encrypt will be used)

## services

- `80/tcp`: http via nginx redirect to https
- `443/tcp`: https via nginx for uptime-kuma

