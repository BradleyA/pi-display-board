# pi-display/create-message

**CPU_usage.sh** is a bash script that returns local CPU usage

**create-display-message.sh** is a bash script that stores Docker information and system information in a file, /usr/local/data/\<CLUSTER\>/\<hostname\>, on each system in SYSTEMS_FILE.  These \<hostname\> files are copied to a host and totaled in a file, /usr/local/data/\<CLUSTER\>/MESSAGE and MESSAGEHD.  The MESSAGE files includes the total number of containers, running containers, paused containers, stopped containers, and number of images.  The MESSAGE files are used by a Raspberry Pi with Pimoroni Scroll-pHAT or Pimoroni Scroll-pHAT-HD to display the information.  The <hostname> file on each system is used by a Raspberry Pi with a Pimoroni blinkt.
    
**create-host-info.sh** is a bash script that stores Docker information and system information in a file, /usr/local/data/\<CLUSTER\>/\<hostname\>.  The Docker information includes the number of containers, running containers, paused containers, stopped containers, and number of images.  The system information includes cpu temperature in Celsius and Fahrenheit, the system load, memory usage, and disk usage.  The \<hostname\> file information is used by a Raspberry Pi with Pimoroni Blinkt to display the system information in near real time.  

## Clone

To clone the entire repository, change to the location you want to download the scripts. Use git to pull or clone these scripts into the directory. If you do not have git then enter; "sudo apt-get install git". On the github page of this script use the "HTTPS clone URL" with the 'git clone' command.

    git clone https://github.com/BradleyA/pi-display
    cd pi-display/create-message/

## Usage

    CPU_usage.sh

## Output

    2019-01-25T11:52:03.596771-06:00 (CST) six-rpi3b.cptx86.com ./CPU_usage.sh[1853] 3.379.575 84 uadmin 10000:10000 [INFO]          Started...
    CPU_USAGE: 11

## Usage

    create-display-message.sh

## Output

    2019-01-25T12:26:46.772467-06:00 (CST) six-rpi3b.cptx86.com ./create-display-message.sh[21143] 3.380.576 121 uadmin 10000:10000 [INFO]  Started...
    2019-01-25T12:27:19.896585-06:00 (CST) six-rpi3b.cptx86.com ./create-display-message.sh[21143] 3.380.576 238 uadmin 10000:10000 [INFO]  Operation finished.

## Usage

    create-host-info.sh

## Output

    2019-01-25T12:35:16.775497-06:00 (CST) six-rpi3b.cptx86.com ./create-host-info.sh[26206] 3.377.573 96 uadmin 10000:10000 [INFO]  Started...
    2019-01-25T12:35:17.305892-06:00 (CST) six-rpi3b.cptx86.com /usr/local/bin/CPU_usage.sh[26253] 3.319.505 79 uadmin 10000:10000 [INFO]  Started...
    2019-01-25T12:35:18.324037-06:00 (CST) six-rpi3b.cptx86.com /usr/local/bin/CPU_usage.sh[26253] 3.319.505 104 uadmin 10000:10000 [INFO]  Operation finished.
    2019-01-25T12:35:18.355122-06:00 (CST) six-rpi3b.cptx86.com ./create-host-info.sh[26206] 3.377.573 154 uadmin 10000:10000 [INFO]  Operation finished.
    
#### WARNING: These instructions below are incomplete. Consider them as notes quickly drafted on a napkin rather than proper documentation!
-> Someday I will place the information in these file into a docker container to read and display the status on the RaspBerry pi blinkt.
3/1/2018 scroll-phat/create-message.sh incluses cpu-temperature
1/25/2019 How to move from crontab scripts to docker containers

cpu-temperature is a bash script that determines the Raspberry pi  temperature (Celsius and Fahrenheit).  The Raspberry Pi stack gets very hot if not cooled.
    
 ## Install
To install, change to the directory, cd /usr/local/bin, to download the script.

    curl -L https://api.github.com/repos/BradleyA/pi-display/tarball | tar -xzf - --wildcards *cpu-temperature/cpu-temperature.sh ; mv BradleyA-pi-display-*/cpu-temperature/cpu-temperature.sh . ; rm -rf BradleyA-pi-display-*
   
#### ARCHITECTURE TREE

#### System OS script tested
 * Ubuntu 16.04.3 LTS (armv7l)

#### Design Principles
 * Have a simple setup process and a minimal learning curve
 * Be usable as non-root
 * Be easy to install and configure

#### License
MIT License

Copyright (c) 2020  [Bradley Allen <img src="https://static.licdn.com/scds/common/u/img/webpromo/btn_viewmy_160x25.png" style="max-width:100%;" >](https://www.linkedin.com/in/bradleyhallen)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

