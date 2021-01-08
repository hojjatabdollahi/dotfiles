#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-d] 

If you run this code with -d flag, it downloads Keepass2.46 and the keepassrpc 1.14.0 and keetraytotp 0.108.0
If you want to have your own version then do these:
download the latest portable Keepass (for windows and mono) from here: https://keepass.info/download.html
extract it where you want it to reside for ever!
downlaod this plugin: https://github.com/kee-org/keepassrpc/releases/latest
downlaod this plugin too: https://github.com/KeeTrayTOTP/KeeTrayTOTP/releases/latest
put the plugins in the plugin folder of the portable keepass
RUN THIS SCRIPT IN THE ROOT OF THE KEEPASS FOLDER WHERE KeePass.exe EXISTS (Do not pass -d to it)

Available options:

-h, --help      Print this help and exit
-d, --default   Download the default version
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  # clean up
  cd ..
  rm -rfd tmp
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  default=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -d | --default) default=1 ;; # example flag
    -p | --param) # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  #[[ -z "${param-}" ]] && die "Missing required parameter: param"
  #[[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
setup_colors

# script logic here

msg "${RED}Read parameters:${NOFORMAT}"
msg "- default: ${default}"
msg "- param: ${param}"
msg "- arguments: ${args[*]-}"


if test $default; then
    sudo apt install unzip
    wget https://phoenixnap.dl.sourceforge.net/project/keepass/KeePass%202.x/2.46/KeePass-2.46.zip
    unzip KeePass-2.46.zip
    rm KeePass-2.46.zip

    cd Plugins
    wget https://github.com/KeeTrayTOTP/KeeTrayTOTP/releases/download/v0.108.0/KeeTrayTOTP.plgx
    wget https://github.com/kee-org/keepassrpc/releases/download/v1.14.0/KeePassRPC.plgx
    cd ..
fi

# Make sure KeePass.exe is in this folder
if test ! -e "KeePass.exe"; then
    die "${RED}Keepass doesn't exists.${NOFORMAT}"; 
fi

# current directory is where keepass.exe exists
EXECADDR=$(pwd)/KeePass.exe\ %f

# install mono
sudo apt install mono-complete

cd $script_dir
# create a temp directory
mkdir tmp
cd tmp
# Download the deb file for icons
wget http://ftp.us.debian.org/debian/pool/main/k/keepass2/keepass2_2.45+dfsg-1_all.deb
# unzip the deb file
ar -x keepass2* 
# unzip the data file inside the deb file
tar -xvf data.tar.xz
# copy the icons into the system
sudo cp -r usr/share/icons /usr/share/
# run sed and change the target of that file
sed -i "s|keepass2 %f|$EXECADDR|g" usr/share/applications/keepass2.desktop
# install the launcher
mkdir -p ~/.local/share/applications
cp usr/share/applications/keepass2.desktop ~/.local/share/applications/keepass2.desktop
chmod +x ~/.local/share/applications/keepass2.desktop

