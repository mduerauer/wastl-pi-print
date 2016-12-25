#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV_FILE=$DIR/../etc/env.sh

if [ -f $ENV_FILE ]; then
	source $ENV_FILE
fi

curl -b $COOKIE_FILE -c $COOKIE_FILE $DEMO_XML_URL
