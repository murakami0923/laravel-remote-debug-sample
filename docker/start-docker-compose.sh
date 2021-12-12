#!/bin/sh

USER_NAME=$(id -un) USER_ID=$(id -u) GROUP_NAME=$(id -gn) GROUP_ID=$(id -g) docker-compose up -d
