# webserver
Infrastructure as code project for my personal web server
using [HashiCorp Terraform](https://www.terraform.io/).

## Resources Built
This project builds the following resources in AWS:
* AWS EC2 Instance
  * Ubuntu on `t2.micro`
* AWS Elastic IP
  * This is important for the DNS records.
* AWS Security Group (and rules)
  * This allows traffic on specified ports.