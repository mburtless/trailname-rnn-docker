#!/usr/bin/env bash
export DOLLAR='$'
envsubst '\$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
nginx -c /etc/nginx/nginx.conf
