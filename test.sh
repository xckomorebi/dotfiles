echo $(dirname "${BASH_SOURCE[0]}")

curDir=$(
    cd $(dirname "$0")
    pwd
)

echo $curDir