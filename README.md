---

## Project: 3-Tier Architecture using Terraform on AWS

### 🛠️ Tools Required

Install these tools **before running Terraform**:

```bash
sudo apt update
sudo apt install -y unzip curl git


✅ Install AWS CLI

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version


✅ Install Terraform

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform
terraform -version


✅ Configure AWS Credentials

aws configure

✅ Apache Web Server Installation (on EC2)

# Update package list and install Apache
sudo apt update
sudo apt install -y apache2

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Go to the default Apache web directory
cd /var/www/html
ls

# Edit or create the index.html file
sudo vi index.html


🔽 Paste the following content into index.html:

<html>
  <body>
    <h1>WEB TIER SUCCESS</h1>
  </body>
</html>


✅ Initialize and Apply Terraform

terraform init
terraform validate
terraform plan
terraform apply


✅ Architecture

VPC with public & private subnets

Internet Gateway & NAT Gateway

Security groups for EC2, RDS

Auto-scaling group with ALB

RDS (MySQL/Postgres)


