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

echo $XML_URL

apt-get install xsltproc curl wkhtmltopdf xvfb
