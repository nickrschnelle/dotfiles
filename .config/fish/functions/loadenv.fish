function loadenv --description 'Load environment variables from .env in the current directory'
    if not test -f .env
        echo "No .env file found in current directory"
        return 1
    end
    for line in (grep -v '^#' .env | grep -v '^\s*$')
        set -gx (string split -m 1 '=' $line)
    end
    echo "Loaded .env"
end
