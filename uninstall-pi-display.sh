#!/bin/bash
# 	uninstall-pi-display.sh  3.367.553  2019-01-18T21:16:13.333884-06:00 (CST)  https://github.com/BradleyA/pi-display  uadmin  six-rpi3b.cptx86.com 3.366  
# 	   ./uninstall-pi-display.sh: line 134: [: too many arguments 
# 	uninstall-pi-display.sh  3.366.552  2019-01-18T21:09:55.328505-06:00 (CST)  https://github.com/BradleyA/pi-display  uadmin  six-rpi3b.cptx86.com 3.365  
# 	   update info user  output uninstall-pi-display.sh close #66 
# 	uninstall-pi-display.sh  3.365.551  2019-01-18T20:50:10.685605-06:00 (CST)  https://github.com/BradleyA/pi-display  uadmin  six-rpi3b.cptx86.com 3.364  
# 	   testing 
# 	uninstall-pi-display.sh  3.363.549  2019-01-18T20:33:04.051259-06:00 (CST)  https://github.com/BradleyA/pi-display  uadmin  six-rpi3b.cptx86.com 3.362  
# 	   complete testing third argument missing, root, and uadmin 
#
### uninstall-pi-display.sh
#   production standard 4
#       Order of precedence: environment variable, default code
if [ "${DEBUG}" == "" ] ; then DEBUG="0" ; fi   # 0 = debug off, 1 = debug on, 'export DEBUG=1', 'unset DEBUG' to unset environment variable (bash)
#       set -x
#       set -v
BOLD=$(tput -Txterm bold)
NORMAL=$(tput -Txterm sgr0)
###
display_help() {
echo -e "\n${NORMAL}${0} - uninstall pi-display"
echo -e "\nUSAGE\n   sudo ${0} "
echo    "   sudo ${0} [<CLUSTER>] [<DATA_DIR>] [<ADMUSER>]"
echo    "   ${0} [--help | -help | help | -h | h | -?]"
echo    "   ${0} [--version | -version | -v]"
echo -e "\nDESCRIPTION"
#       Displaying help DESCRIPTION in English en_US.UTF-8
echo    "This script has to be run as root to uninstall /<DATA_DIR>/<CLUSTER>.  The"
echo    "commands will be uninstalled from /usr/local/bin and the logs from"
echo    "/<DATA_DIR>/<CLUSTER> directory.  The /<DATA_DIR>/<CLUSTER>/SYSTEMS file"
echo    "will not be removed because the SYSTEMS file is also used by"
echo    "Linux-admin/cluster-command/cluster-command.sh, markit/find-code.sh,"
echo    "pi-display/create-message/create-display-message.sh, and other scripts."
#       Displaying help DESCRIPTION in French
if [ "${LANG}" == "fr_CA.UTF-8" ] || [ "${LANG}" == "fr_FR.UTF-8" ] || [ "${LANG}" == "fr_CH.UTF-8" ] ; then
        echo -e "\n--> ${LANG}"
        echo    "<votre aide va ici>" # your help goes here
        echo    "Souhaitez-vous traduire la section description?" # Do you want to translate the description section?
elif ! [ "${LANG}" == "en_US.UTF-8" ] ; then
	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[WARN]${NORMAL}  Your language, ${LANG}, is not supported.  Would you like to translate the description section?" 1>&2
fi
echo -e "\nOPTIONS"
echo    "   CLUSTER         name of cluster directory, default us-tx-cluster-1"
echo    "   DATA_DIR        path to cluster data directory, default /usr/local/data/"
echo    "   ADMUSER         site SRE administrator, default is user running script"
echo -e "\nDOCUMENTATION\n    https://github.com/BradleyA/pi-display-board"
echo -e "\nEXAMPLES\n   sudo ${0}\n"
echo -e "   sudo ${0} us-tx-cluster-1 /usr/local/data\n"
}

#       Date and time function ISO 8601
get_date_stamp() {
DATE_STAMP=$(date +%Y-%m-%dT%H:%M:%S.%6N%:z)
TEMP=$(date +%Z)
DATE_STAMP="${DATE_STAMP} (${TEMP})"
}

#       Fully qualified domain name FQDN hostname
LOCALHOST=$(hostname -f)

#       Version
SCRIPT_NAME=$(head -2 "${0}" | awk {'printf $2'})
SCRIPT_VERSION=$(head -2 "${0}" | awk {'printf $3'})

#       UID and GID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

#       Default help and version arguments
if [ "$1" == "--help" ] || [ "$1" == "-help" ] || [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "h" ] || [ "$1" == "-?" ] ; then
        display_help | more
        exit 0
fi
if [ "$1" == "--version" ] || [ "$1" == "-version" ] || [ "$1" == "version" ] || [ "$1" == "-v" ] ; then
        echo "${SCRIPT_NAME} ${SCRIPT_VERSION}"
        exit 0
fi

#       INFO
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Started..." 1>&2

#       DEBUG
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Name_of_command >${0}< Name_of_arg1 >${1}< Name_of_arg2 >${2}< Name_of_arg3 >${3}<  Version of bash ${BASH_VERSION}" 1>&2 ; fi

###
#       Must be root to run this script
if ! [ "$(id -u)" = 0 ] ; then
	display_help | more
	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  Use sudo ${0}" 1>&2
	echo -e "\n>>   ${BOLD}SCRIPT MUST BE RUN AS ROOT${NORMAL} <<"  1>&2
        exit 1
fi

#       Order of precedence: CLI argument, environment variable, default code
if [ $# -ge  1 ]  ; then CLUSTER=${1} ; elif [ "${CLUSTER}" == "" ] ; then CLUSTER="us-tx-cluster-1/" ; fi
#       Order of precedence: CLI argument, environment variable, default code
if [ $# -ge  2 ]  ; then DATA_DIR=${2} ; elif [ "${DATA_DIR}" == "" ] ; then DATA_DIR="/usr/local/data/" ; fi
#       Order of precedence: CLI argument
if [ $# -ge  3 ]  ; then ADMUSER=${3} ; else ADMUSER="${USER}" ; echo -e "\n\t${BOLD}Warning:  ${ADMUSER} crontab will be removed . . ." ; fi
#
if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Variable... CLUSTER >${CLUSTER}< DATA_DIR >${DATA_DIR}< ADMUSER >${ADMUSER}<" 1>&2 ; fi

###	Remove instructions from ${ADMUSER} crontab
if [ -e /var/spool/cron/crontabs/"${ADMUSER}" ] ; then
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Remove ${DATA_DIR}/${CLUSTER}/logrotate/*${LOCALHOST}-crontab" 1>&2 ; fi
	DATE_STAMP=$(date +%Y-%m-%dT%H:%M:%S.%6N%:z)
	echo -e "\n\tRemoving content from /var/spool/cron/crontabs/${ADMUSER}" 1>&2
	echo -e "\tA backup copy of this file can be found, /var/spool/cron/crontabs/${ADMUSER}.${DATE_STAMP}" 1>&2
	echo -e "\n\t${BOLD}Edit /var/spool/cron/crontabs/${ADMUSER} using crontab -e\n" 1>&2
	cp /var/spool/cron/crontabs/"${ADMUSER}" /var/spool/cron/crontabs/"${ADMUSER}"."${DATE_STAMP}"
	head -n 3 /var/spool/cron/crontabs/"${ADMUSER}"."${DATE_STAMP}" >  /var/spool/cron/crontabs/"${ADMUSER}"
else
	get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[ERROR]${NORMAL}  /var/spool/cron/crontabs/${ADMUSER} not found" 1>&2
fi

#   Remove scripts and files
rm /usr/local/bin/display-led.py
rm /usr/local/bin/display-led-test.py
rm /usr/local/bin/CPU_usage.sh
rm /usr/local/bin/create-display-message.sh
rm /usr/local/bin/create-host-info.sh
rm /usr/local/bin/display-message.py
rm /usr/local/bin/display-scrollphat-test.py
rm /usr/local/bin/display-message-hd.py
rm /usr/local/bin/display-scrollphathd-test.py
#
rm ${DATA_DIR}/${CLUSTER}/logrotate/pi-display-logrotate
#
if [ -e "${DATA_DIR}"/"${CLUSTER}"/logrotate/EXT ] ; then
	rm ${DATA_DIR}/${CLUSTER}/logrotate/EXT
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Remove ${DATA_DIR}/${CLUSTER}/logrotate/EXT" 1>&2 ; fi
else
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  ${DATA_DIR}/${CLUSTER}/logrotate/EXT not found" 1>&2 ; fi
fi
#
if [ -e "${DATA_DIR}/${CLUSTER}/logrotate/*${LOCALHOST}"-crontab ] ; then
	rm ${DATA_DIR}/${CLUSTER}/logrotate/*"${LOCALHOST}"-crontab
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Remove ${DATA_DIR}/${CLUSTER}/logrotate/*${LOCALHOST}-crontab" 1>&2 ; fi
else
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  ${DATA_DIR}/${CLUSTER}/logrotate/*${LOCALHOST}-crontab not found" 1>&2 ; fi
fi
#
if [ -e ${DATA_DIR}/${CLUSTER}/log/"${LOCALHOST}"-crontab ] ; then
	rm ${DATA_DIR}/${CLUSTER}/log/"${LOCALHOST}"-crontab
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  Remove ${DATA_DIR}/${CLUSTER}/log/${LOCALHOST}-crontab" 1>&2 ; fi
else
	if [ "${DEBUG}" == "1" ] ; then get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[DEBUG]${NORMAL}  ${DATA_DIR}/${CLUSTER}/log/${LOCALHOST}-crontab not found" 1>&2 ; fi
fi

###     remove clone directories and files
cd ..
#       Check if directory 
if [ -d ./pi-display ] ; then
        echo -e "\n\tRemoving directory ./pi-display"
        rm -rf ./pi-display/
else
        get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  ./pi-display/ directory not found"  1>&2
fi

#
get_date_stamp ; echo -e "${NORMAL}${DATE_STAMP} ${LOCALHOST} ${0}[$$] ${SCRIPT_VERSION} ${LINENO} ${USER} ${USER_ID}:${GROUP_ID} ${BOLD}[INFO]${NORMAL}  Operation finished." 1>&2
###
