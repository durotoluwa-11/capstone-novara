# Cost Analysis

## Monthly Cost Estimate (us-east-1)

### Kubernetes Cluster (Kops)

| Resource | Type | Quantity | Unit Price | Monthly Cost |
|----------|------|----------|------------|--------------|
| Master Nodes | t3.medium | 3 | $30.37/mo | $91.11 |
| Worker Nodes | t3.medium | 3 | $30.37/mo | $91.11 |
| EBS Volumes (nodes) | gp3 20GB | 6 | $1.60/mo | $9.60 |

### Networking

| Resource | Type | Quantity | Unit Price | Monthly Cost |
|----------|------|----------|------------|--------------|
| NAT Gateways | per AZ | 3 | $32.40/mo | $97.20 |
| Elastic IPs | per NAT | 3 | $3.60/mo | $10.80 |
| Data Transfer | ~100GB | 1 | $9.00/mo | $9.00 |

### Storage

| Resource | Type | Quantity | Unit Price | Monthly Cost |
|----------|------|----------|------------|--------------|
| Database EBS | gp3 20GB | 1 | $1.60/mo | $1.60 |
| S3 Kops State | ~1GB | 1 | $0.023/mo | $0.02 |
| S3 Terraform State | ~1GB | 1 | $0.023/mo | $0.02 |

### Other

| Resource | Type | Quantity | Unit Price | Monthly Cost |
|----------|------|----------|------------|--------------|
| Route53 Hosted Zone | per zone | 1 | $0.50/mo | $0.50 |
| DynamoDB | pay per request | 1 | ~$0.50/mo | $0.50 |

## Total Estimated Monthly Cost

| Category | Cost |
|----------|------|
| Compute | $182.22 |
| Networking | $117.00 |
| Storage | $1.64 |
| Other | $1.00 |
| **Total** | **~$301.86/mo** |

## Cost Optimization Recommendations

1. **Use Spot Instances** for worker nodes — can save up to 70%
2. **Single NAT Gateway** for dev/test environments
3. **Reserved Instances** for masters if running long term
4. **Set AWS Budget Alert** at $50 to avoid surprises

## AWS Budget Alert Setup
1. Go to AWS Console → Billing → Budgets
2. Click "Create budget"
3. Set amount to $50
4. Add your email for alerts
