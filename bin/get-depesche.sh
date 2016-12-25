#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV_FILE=$DIR/../etc/env.sh

if [ -f $ENV_FILE ]; then
	source $ENV_FILE
fi

TEMP_FILE=`tempfile -d $TEMP_DIR -p wastl- -s .xml`
HTML_FILE=`tempfile -d $HTML_DIR -p wastl- -s .html`
PDF_FILE=`tempfile -d $PDF_DIR -p wastl- -s .pdf`

curl -s -b $COOKIE_FILE -c $COOKIE_FILE $DEMO_XML_URL > $TEMP_FILE

sed -i "s/utf\-16/utf\-8/g" $TEMP_FILE

xsltproc $XSL_FILE $TEMP_FILE > $HTML_FILE

$DIR/wkhtmltopdf-xvfb $HTML_FILE $PDF_FILE
