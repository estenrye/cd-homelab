set -x
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail

# get build.sh parent directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ${SCRIPT_DIR}
brew bundle

cat ${SCRIPT_DIR}/VSCodeExtensions | xargs -I % sh -c 'code --install-extension %'
cat ${SCRIPT_DIR}/Krewfile | xargs -I % sh -c 'kubectl krew install %'
cat ${SCRIPT_DIR}/GoTools | xargs -I % sh -c 'go install -v %'