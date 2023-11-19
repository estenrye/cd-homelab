kubectl create namespace 1password
kubectl create -n 1password secret generic op-credentials --from-literal=1password-credentials.json=`op read op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64`
kubectl create -n 1password secret generic onepassword-token --from-literal=token=`op read op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential`
kustomize build --enable-helm ~/src/cd-homelab/applications/1password | kubectl apply -f -