Note: This will not use a lot of resources, but make sure you run terraform destroy after you're done to avoid getting any extra bills. Under the free tier this won't push you toward you limit too hard. 

Based on the tutorial located here https://dev.to/aakatev/deploy-ec2-instance-in-minutes-with-terraform-ip2

For this main.tf to run, create a key pair using ssh-keygen. Edit the public key to the aws_key_pair if using a name other than "terraform".