#!/bin/sh
set -x

systemctl daemon-reload
systemctl enable samplicator.service
systemctl start samplicator.service
