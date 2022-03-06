#!/bin/bash
# ---------------------------------------------------------------------------- #
# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.        #
# Copyright (C) 2022  Jonas Hügli                                              #
# ---------------------------------------------------------------------------- #
# Author ......................................................... Jonas Hügli #
# Mail .................................................. huglijonas@gmail.com #
# Project .................. https://github.com/huglijonas/almalinux_hardening #
# Purpose ........................................... Create a new custom rule #
# Script version ....................................................... 1.0.0 #
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Variables                                                                    #
# ---------------------------------------------------------------------------- #
SCRIPT_version='1.0.0'
SCRIPT_VERBOSE=false
REGEX_RULENAME='[a-z_+\/]+$'
MODULE_NAME='almalinux_hardening'
CUSTOM_RULE_BASEPATH='./manifests/custom'
CUSTOM_RULE_SPEC_BASEPATH='./spec/classes/custom'
YAML_OS_FILE='./data/os/AlmaLinux/version/8.yaml'



# ---------------------------------------------------------------------------- #
# Main check                                                                   #
# ---------------------------------------------------------------------------- #
if [ "$(basename `pwd`)" != ${MODULE_NAME} ]; then
  echo "[ERROR] Please run this script in the root of the '${MODULE_NAME}' module."
  exit 1
elif [ ! -d ${CUSTOM_RULE_BASEPATH} ]; then
  echo "[ERROR] The '${CUSTOM_RULE_BASEPATH}' directory seems to be missing!"
  exit 1
elif [ ! -d ${CUSTOM_RULE_SPEC_BASEPATH} ]; then
  echo "[ERROR] The '${CUSTOM_RULE_SPEC_BASEPATH}' directory seems to be missing!"
  exit 1
elif [ ! -f ${YAML_OS_FILE} ]; then
  echo "[ERROR] The '${YAML_OS_FILE}' file seems to be missing!"
  exit 1
elif ! grep -Pq '^almalinux_hardening::server_custom:$' ${YAML_OS_FILE}; then
  echo "[ERROR] It seems the file '${YAML_OS_FILE}' has a problem... be certain the line 'almalinux_hardening::server_custom:' exists at the end of the file!"
  exit 1
fi



# ---------------------------------------------------------------------------- #
# GENERIC FUNCTIONS                                                            #
# ---------------------------------------------------------------------------- #
# Version - Display version informations
# ------------------------------------------------------------------------------
function version() {
  cat << EOM
# ---------------------------------------------------------------------------- #
#                                SCRIPT version                                #
# ---------------------------------------------------------------------------- #
# Author ......................................................... Jonas Hügli #
# Mail .................................................. huglijonas@gmail.com #
# Project .................. https://github.com/huglijonas/almalinux_hardening #
# Purpose ........................................... Create a new custom rule #
# Script Version ....................................................... ${SCRIPT_version} #
# ---------------------------------------------------------------------------- #
EOM
}

# Help - Display help informations
# ------------------------------------------------------------------------------
function help() {
  cat << EOM
Usage:  custom-rule.sh      -n <rulename>
                            [-v]
                            [-V]
                            [-h]

Mandatory:  -n, --name      Set the name of the new custom rule. You can provide
                            an unique name, or a path like 'kernel/custom' or
                            'kernel/modules/load'.
Optional:   -v, --verbose   Enable the verbose mode.
Informal:   -V, --version   Display informations about this script.
Informal:   -h, --help      Display this message.
EOM
}



# ---------------------------------------------------------------------------- #
# Parameters and options                                                       #
# ---------------------------------------------------------------------------- #
PARSED_ARGUMENTS=$(getopt -o n:vVh --long name:,verbose,version,help -- "$@")
VALID_ARGUMENTS=$?

if [ "$VALID_ARGUMENTS" != "0" ]; then
  help
  exit 1
elif [ "${PARSED_ARGUMENTS[*]}" == "--" ]; then
  help
  exit 1
fi

eval set -- "$PARSED_ARGUMENTS"
while true; do
  case "$1" in
    -n | --name)    RULE_NAME="$2";       shift 2;;
    -v | --verbose) SCRIPT_VERBOSE=true;  shift;;
    -V | --version) version; exit 0;      shift;;
    -h | --help)    help; exit 0;         shift;;
    --) shift; break;;
    *) echo "$1: Invalid parameter..."; help; exit 1;;
  esac
done

# Rule name check
# ------------------------------------------------------------------------------
if [ -z ${RULE_NAME} ]; then
  echo -e "[ERROR] You need to specify a name for your new custom rule!\n"
  help
  exit 1
elif [[ ! "${RULE_NAME}" =~ ${REGEX_RULENAME} ]]; then
  echo "[ERROR] The name '${RULE_NAME}' must be validated by the following regex: '^[a-z_+\/]+\$'"
  echo "True:   kernel, custom_kernel, kernel/custom"
  echo "False:  kernel::custom, ./kernel/custom"
  exit 2
fi

# If containing directory
# ------------------------------------------------------------------------------
if [[ "${RULE_NAME}" =~ /\// ]]; then
  CUSTOM_RULE_DIRECTORY=$(echo "${RULE_NAME}" | sed -n 's/^[a-z_+\/]*\(\/\(.*\)\)$/\1/p')
  CUSTOM_RULE_FILENAME=$(echo "${RULE_NAME}" | sed -n 's/^[a-z_+\/]*\(\/\(.*\)\)$/\3/p')
  # Class
  # ----------------------------------------------------------------------------
  if [ ! -d "${CUSTOM_RULE_BASEPATH}/${CUSTOM_RULE_DIRECTORY}" ]; then
    mkdir -p "${CUSTOM_RULE_BASEPATH}/${CUSTOM_RULE_DIRECTORY}"
  fi

  # Spec
  # ----------------------------------------------------------------------------
  if [ ! -d "${CUSTOM_RULE_SPEC_BASEPATH}/${CUSTOM_RULE_DIRECTORY}" ]; then
    mkdir -p "${CUSTOM_RULE_SPEC_BASEPATH}/${CUSTOM_RULE_DIRECTORY}"
  fi
else
  CUSTOM_RULE_DIRECTORY=''
  CUSTOM_RULE_FILENAME=$RULE_NAME
fi
CLASS_NAME=$(echo ${RULE_NAME} | sed 's/\//::/g')
if grep -Pq "^- ${MODULE_NAME}::custom::${CLASS_NAME}\$" ${YAML_OS_FILE}; then
  echo "[ERROR] The custom class is already declared in '${YAML_OS_FILE}'!"
  exit 1
elif [ -d "${CUSTOM_RULE_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}.pp" ]; then
  echo "[ERROR] The file '${CUSTOM_RULE_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}.pp' already exists!"
  exit 1
elif [ -d "${CUSTOM_RULE_SPEC_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}_spec.rb" ]; then
  echo "[ERROR] '${CUSTOM_RULE_SPEC_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}_spec.rb' already exists!"
  exit 1
fi


# ---------------------------------------------------------------------------- #
# Main                                                                         #
# ---------------------------------------------------------------------------- #
echo "[BEGIN]"

# Create class file
# ------------------------------------------------------------------------------
while true; do
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -ne "[INFO] Adding the new custom rule class file... ${e}\r"; fi
  cat > "${CUSTOM_RULE_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}.pp" << EOM
# @summary
#   Custom rule summary
#
# @description
#   Custom rule description
#
# @rationale
#   Custom rule rationale
#
# @example
#   include ${MODULE_NAME}::custom::${CLASS_NAME}
class ${MODULE_NAME}::custom::${CLASS_NAME} {
  # Insert code here
}
EOM
  if [ $? -eq 0 ]; then e='OK'; elif [ $? -ne 0 ]; then e='ERROR'; fi
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -e "[INFO] Adding the new custom rule class file... ${e}\r"; fi
  if [ ${e} == 'ERROR' ]; then echo "[ERROR] An error occured when adding the new custom rule class file..."; exit 1; fi
  break
done

# Create spec file
# ------------------------------------------------------------------------------
while true; do
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -ne "[INFO] Adding the new spec file... ${e}\r"; fi
  cat > "${CUSTOM_RULE_SPEC_BASEPATH}/${CUSTOM_RULE_DIRECTORY}/${CUSTOM_RULE_FILENAME}_spec.rb" << EOM
# frozen_string_literal: true

require 'spec_helper'

describe '${MODULE_NAME}::custom::${CLASS_NAME}' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
EOM
  if [ $? -eq 0 ]; then e='OK'; elif [ $? -ne 0 ]; then e='ERROR'; fi
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -e "[INFO] Adding the new spec file... ${e}\r"; fi
  if [ ${e} == 'ERROR' ]; then echo "[ERROR] An error occured when adding the new spec file..."; exit 1; fi
  break
done


# Add custom rule in YAML OS File
# ------------------------------------------------------------------------------
while true; do
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -ne "[INFO] Adding custom rule in YAML OS file... ${e}\r"; fi
  echo "- ${MODULE_NAME}::custom::${CLASS_NAME}" >> ${YAML_OS_FILE}
  if [ $? -eq 0 ]; then e='OK'; elif [ $? -ne 0 ]; then e='ERROR'; fi
  if [ ${SCRIPT_VERBOSE} = true ]; then echo -e "[INFO] Adding custom rule in YAML OS file... ${e}\r"; fi
  if [ ${e} == 'ERROR' ]; then echo "[ERROR] An error occured when adding the new custom rule in YAML OS file..."; exit 1; fi
  break
done

# Finish
# ------------------------------------------------------------------------------
echo "[FINISH]"
exit 0
