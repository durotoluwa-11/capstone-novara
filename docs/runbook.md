# Runbook

## Prerequisites
- AWS CLI installed and configured
- kubectl installed
- kops installed
- Terraform installed

## 1. Deploy the Application

### Step 1 - Initialize Terraform
```bash
cd terraform/environments/prod
terraform init
terraform plan
terraform apply
```

### Step 2 - Create Kops Cluster
```bash
export KOPS_STATE_STORE=s3://durotoluwa-kops-state-store

kops create -f kops/cluster.yaml
kops create -f kops/instance-groups.yaml
kops update cluster --name taskapp.durotoluwa-tasked.com --yes
```

### Step 3 - Validate Cluster
```bash
kops validate cluster --wait 10m
kubectl get nodes
```

### Step 4 - Deploy Application
```bash
bash scripts/deploy.sh
```

## 2. Scale the Cluster

### Scale Worker Nodes
```bash
kops edit ig nodes-us-east-1a
# Change minSize and maxSize
kops update cluster --name taskapp.durotoluwa-tasked.com --yes
kops rolling-update cluster --yes
```

### Scale Application
```bash
kubectl scale deployment taskapp-frontend --replicas=3 -n taskapp
kubectl scale deployment taskapp-backend --replicas=3 -n taskapp
```

## 3. Rotate Secrets

### Rotate Database Password
```bash
# Generate new password
NEW_PASSWORD=$(openssl rand -base64 32)

# Update secret
kubectl create secret generic postgres-secret \
  --from-literal=POSTGRES_PASSWORD=$NEW_PASSWORD \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart backend
kubectl rollout restart deployment/taskapp-backend -n taskapp
```

## 4. Troubleshooting

### Pods not starting
```bash
kubectl get pods -n taskapp
kubectl describe pod <pod-name> -n taskapp
kubectl logs <pod-name> -n taskapp
```

### SSL certificate not issuing
```bash
kubectl get certificates -n taskapp
kubectl describe certificate taskapp-frontend-tls -n taskapp
kubectl get clusterissuer
```

### Database connection issues
```bash
kubectl exec -it <backend-pod> -n taskapp -- env | grep DATABASE
kubectl get pods -n taskapp | grep postgres
```

## 5. Destroy Everything
```bash
bash scripts/destroy.sh
```
