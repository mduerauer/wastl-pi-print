# WASTL Depeschendruck am Raspberry Pi

## Quick Installation

+ Open a terminal
+ Clone this repository: `git clone git@github.com:mduerauer/wastl-pi-print.git`
+ Run `sudo install/install.sh` to install the required Raspian packages
+ Configure a default printer in CUPS (see Printer Configuration)
+ Run `bin/get-depesche.sh` to print a Depesche 

##  CUPS Printer Configuration

### Add yourself to the lpadmin group
* Open a terminal
* Run `sudo usermod -a -G lpadmin <your-username>`

### Add a printer

#### Option 1: system-config-printer
+ Open a terminal
+ Run `sudo system-config-printer`
+ Add a printer

#### Option 2: CUPS WebUI
+ Open a web browser
+ Open the URL `http://localhost:631`
+ Login using your Linux credentials
+ ...