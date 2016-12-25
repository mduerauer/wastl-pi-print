#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$USER" != "root" ]; then
	echo "Please run the installation script as root!"
	exit 1
fi

ENV_FILE=$DIR/etc/env.sh

if [ -f $ENV_FILE ]; then
        source $ENV_FILE
fi

PACKAGES="xsltproc curl wkhtmltopdf xvfb cups system-config-printer"
apt-get install $PACKAGES
