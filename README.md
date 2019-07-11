# Ben Coughlan 

Since we're currently in flux between major versions of terraform in 11/12, I felt it better to just keep it simple, and not try to impress you with some hacky functions. 

Please run the following with terraform: (tested with version 11.4 and 12.3)
```
terraform init

terraform plan

terraform apply

```

## Q1.  When would you use Google Kubernetes Engine managed Kubernetes instead of having full control with a full deployment using Kops/Rancher etc?

I would use GKE, or another managed kubernetes in most instances, as
it comes with a plethora of stability benefits for free off the bat. 
 The instances where I would look at running Kops, or similar, are:  

 1. Where we don't have the luxury of GKE/AWS in place, i.e. in private cloud, bare metal, dev machine, local machine, etc.  
 2. A region without a public cloud vendor. 
 3. Where you have to install a cluster in an air gapped location ( i.e. in another clients site ). 
 4. Where you're trying to make and maintain significant hosting cost reductions.

## Q2.  What would you do to a Kubernetes cluster to run production workloads?

 1. Namespacing 
 2. IAM roles/permissions for ebs/volume autoscaling 
 3. Kube2iam/Google-to-iam 
 4. RBAC 
 5. external DNS 
 6. Autoscaling the cluster/ auto provisioning the cluster. 
 7.  Telemetry - APM/Logs/Metrics/Active checks.  
 8. istio/LinkerD 
 9. A solid deployment tool, one that can abstract away the kubernetes api from developers. ([i.e. shipcat](https://github.com/Babylonpartners/shipcat))
 10. Ingress 



## Q3.   Explain the difference between an ingress controller and a service, when would you use either?

 A Service generally sits in front/manages a group of pods.  An Ingress
 Controller generally sits in front of one or more services. 
 
 Ingress is useful for opening multiple services, it can do so by
 namespace, or even by cluster, and can save you a lot in hosting of
 load balancers, you also get a lot of features for free (like SSL,
 Auth, Routing, etc). Newer ingress controllers like GCLB and istio,
 can handle much more for you. 
 
 A Service on the other hand, will sit in front of a group of pods for
you, and while the pods will be transient, and may disappear at any
 time, the service can account for this.

## Q4.    How would you globally serve internet traffic to an API deployed in three regions using same domain name?

 1. Ensure Data replication is handled in all regions. 
 2. Ensure you have a global network infrastructure, and use vpc peering where necessary.  
 3. Use Cross Region load balancing  
 4. Use Global Routing Mode.

## Q5. What is a shared VPC and how does it compare to vpc peering?

 - When you use VPC peering, GCP will create routes in each VPC to link them, these links may clash if network topologies aren't thought out in advance, and traffic may run publically, causing lag. 
 - A Shared VPC will scale much better, and tend to be much easier to manage.


## Q6.How do you ensure the state files in Terraform are lockable so are not overwritten by a work colleague?

 - In AWS: link them to a DynamoDB table
 - in GCP, use GCS with state locking.

## Q7.  When would you use Ansible/Salt instead of terraform?

> Traditionally, one would use Ansible/Salt for the config management
> step, whereas you'd use Terraform for orchestration. Personally
> however, I'd use CoreOS/ignition instead of Ansible/Salt/Chef/Puppet,
> I'd stop using agent based config management, because it's divergent,
> agentless congruent CM allows you to stop logging into
> machines.[Igniton](https://coreos.com/ignition/docs/latest/)


## Q8. How would you do traffic splitting to A/B version of a service in Kubernetes?

> Traffic splitting can be done on the ingress with kubernetes, usually
> by weighting scores per service  version.


## Q9.  How would you allow multiple pods to write to the same volume mount in K8s?

> Allow the access mode to be: ReadWriteMany

## Q10. How do you ensure a rolling deployment is successful in Kubernetes?

> Creating new pods before deleting old ones.  Livelines/Readiness
> checks.  Setting sa sensible rollingUpdate strategy on each
> deployment.

