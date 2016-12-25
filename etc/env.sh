#!/bin/bash

PIPR_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

BASE_URL="https://infoscreen.florian10.info/ows/infoscreen"

DEMO_XML_URL="$BASE_URL/demo.ashx?demo=3&f=xml"
XML_URL="$BASE_URL/einsatz.ashx?f=xml"

COOKIE_FILE=$PIPR_HOME/var/wastl.cookies
