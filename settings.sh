#
# SEE THE BOTTOM OF THIS FILE TO ADD MORE SETTINGS
# SETTINGS WILL BE SAVED IN THE KEYCHAIN AS PASSWORDS
#

# https://www.commandlinefu.com/commands/view/24201/get-hardware-uuid-in-mac-os-x
_hardware_uuid=$(system_profiler SPHardwareDataType | awk '/UUID/ { print $3; }')

function get_setting_from_keychain()
{
  local service='dotfiles'
  local creator='dotf' # always for chars
  local account=$1
  local info=$2

  local identifier="-s ${service} -a ${account} -c ${creator}"
  local label="${service}/${account}"
  local find_cmd="security find-generic-password ${identifier}"
  local read_cmd="${find_cmd} -w"
  local write_cmd="security add-generic-password ${identifier} -l ${label}"

  set +e
  $find_cmd >/dev/null 2>/dev/null
  status=$?
  set -e
  if [[ $status -ne 0 ]]; then
    echo "Please specify the value for $account as a password" >&2
    echo $info >&2
    $write_cmd -w
  fi
  # always read, so we are sure that the write worked
  $read_cmd
}

function remove_when_changed()
{
  local service='dotfiles'
  local creator='dotf' # always for chars
  local hw_account='hardware_uuid'
  local account=$1

  local shared_identifier="-s ${service} -c ${creator}"
  local hw_read_cmd="security find-generic-password ${shared_identifier} -a ${hw_account} -w"
  local find_cmd="security find-generic-password ${shared_identifier} -a ${account}"
  local delete_cmd="security delete-generic-password ${shared_identifier} -a ${account}"

  stored_uuid=$($hw_read_cmd 2>/dev/null || echo '')
  if [[ "${stored_uuid}" != "${_hardware_uuid}" ]]; then
      if $find_cmd 2>/dev/null; then
        # remove the computer name
        $delete_cmd
      fi
  fi
}

function update_hardware_uuid()
{
  local service='dotfiles'
  local creator='dotf' # always for chars
  local account='hardware_uuid'
  security add-generic-password \
    -s ${service} -c ${creator} -a ${account} \
    -l "${service}/${account}" \
    -U -w ${_hardware_uuid}
}


# We save all our settings in the keychain
# Remove per-device settings
remove_when_changed COMPUTER_NAME
# save the current device
update_hardware_uuid

# read from keychain or ask for input
COMPUTER_NAME=$(get_setting_from_keychain COMPUTER_NAME 'This will be used as the hostname')
HOMEBREW_GITHUB_API_TOKEN=$(get_setting_from_keychain HOMEBREW_GITHUB_API_TOKEN 'https://github.com/settings/tokens')
MOOM_LICENCES_BASE64=$(get_setting_from_keychain MOOM_LICENCES_BASE64 'cat moomlicense | base64 | pbcopy # you might have to update this in KeyChain Access')
