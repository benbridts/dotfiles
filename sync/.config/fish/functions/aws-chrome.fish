function aws-chrome -d "start a new chrome browser logged in to aws"
    # set to yes to create profiles /tmp
    # anythin else will create them in $HOME/.aws/awschrome
    set -l TEMP_PROFILE "yes"

    # set to yes to always start in a new window
    set -l NEW_WINDOW "no"

    set -l profile "$argv[1]"
    if test -z "$profile"
        echo "Profile is a required argument" >&2
        return 1
    end

    # replace / and whitespace with __
    set -l profile_dir_name (string replace -ar '[\W/]' __ "$profile")
    set -l user_data_dir "$HOME/.aws/awschrome/$profile_dir_name"
    set -l set new_window_arg ''

    if test "$TEMP_PROFILE" = "yes"
        set user_data_dir (mktemp -d /tmp/awschrome_userdata.XXXXXXXX)
    end

    if test "$NEW_WINDOW" = "yes"
        set new_window_arg '--new-window'
    end

    # run aws-vault
    # --prompt osascript only works on OSX
    set -l url (aws-vault login $profile --stdout --prompt osascript)

    if test $status -ne 0
        # fish will also capture stderr, so echo $url
        echo $url >&2
        return $status
    end

    mkdir -p $user_data_dir
    set -l disk_cache_dir (mktemp -d /tmp/awschrome_cache.XXXXXXXX)
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
        --no-first-run \
        --user-data-dir=$user_data_dir \
        --disk-cache-dir=$disk_cache_dir \
        $new_window_arg \
        $url \
      >/dev/null 2>&1 &
end
