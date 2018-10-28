function aws-url -d "get chrome session url"
    set -l profile "$argv[1]"
    if test -z "$profile"
        echo "Profile is a required argument" >&2
        return 1
    end
    
    # call sts to make sure there is a cached session
    set -l user_id (aws --profile $profile sts get-caller-identity | jq -r .UserId)
    
    set -l r_token (cat ~/.aws/cli/cache/*.json | jq -c '.' | grep $user_id | jq -c '{sessionId: .Credentials.AccessKeyId, sessionKey: .Credentials.SecretAccessKey, sessionToken: .Credentials.SessionToken }' | python -c "import sys, urllib as ul; print ul.quote_plus(sys.stdin.read())")
    set -l s_token (http "https://signin.aws.amazon.com/federation?Action=getSigninToken&SessionDuration=1800&Session=$r_token" | jq -r '.SigninToken')
    
     echo "https://signin.aws.amazon.com/federation?Action=login&Destination=https%3A%2F%2Fconsole.aws.amazon.com&Issuer=aws-url&SigninToken=$s_token"
    
end
