Deleting apps in Argo CD somehow causes the app to get stuck on deleting status even when the finalizers are already set.

run the command below for cleanup:

kubectl patch application argo-express-api --type=json -p='[{"op": "remove", "path": "/metadata/finalizers"}]' -n argocd