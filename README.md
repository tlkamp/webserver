# webserver
Infrastructure as code project for my personal web server
using HashiCorp Terraform.

## Resources Built
This project builds the following resources in AWS:
* AWS EC2 Instance
  * Ubuntu on `t2.micro`
* AWS Elastic IP
  * This is important for the DNS records.
