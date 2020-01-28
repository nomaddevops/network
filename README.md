# Module VPC

Last update : 18/09/2018

# SUMMARY

- [INTRODUCE](#Introduce)
- [In_details](#In_details)
- [TECHNICAL_DOCUMENTATION](docs/technical_docs.md)
- [KNOWN_ISSUES](docs/issues.md)
- [CHANGELOG](docs/change_log.md)

# Introduce
This module deploy a VPC (Virtual Private Cloud) currently on AWS, at term it'll evolve to support GCP (Google Cloud Plateform) or any other cloud providers.

This module will evolve so stay tuned

To consult recent changes and evolutions, see the CHANGELOG.md file

# In_details
This module use conditionals vars to deploy resources, in the case you choose to deploy this module without setting the optionals vars you'll only have a VPC and nothing more.

Please check the Optionals vars part if you want to deploy :

 - Public subnets with NAT Gateways (and their route tables)
 - Private subnets and their route tables
 - Enable DNS resolution inside the vpc
 - Enable FlowLogs
    - with default cloudwatch log group expire rule (7d)
 - Force S3 logging bucket creation
    - with default object expire rules
        - 15d : standard_ia
        - 30d : onezone_ia
        - 60d : glacier
        - 90d : Finally expire
 - Kinesis data stream to send CWL logs to s3 (via Lambda function)
 - Enable IPv6
 - Enable ClassicLink
 - Set default instance tenancy
 - Configure VPN Connections
 - Configure NACL (Network ACL)
 - Configure VPC Peering

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| accepter\_allow\_classic\_link\_to\_remote\_vpc | Allow vpc accepter classic link on remote | `bool` | `false` | no |
| accepter\_allow\_remote\_vpc\_dns\_resolution | Allow vpc accepter dns resolution | `bool` | `false` | no |
| accepter\_allow\_vpc\_to\_remote\_classic\_link | Allow vpc accepter classic link from current vpc | `bool` | `false` | no |
| amazon\_side\_asn | n/a | `number` | `65000` | no |
| assign\_generated\_ipv6\_cidr\_block | n/a | `bool` | `false` | no |
| bgp\_asn | n/a | `list(string)` | <pre>[<br>  "64999"<br>]<br></pre> | no |
| cidr\_block | Enter the cidr block for your VPC | `any` | n/a | yes |
| cwl\_retention\_in\_days | Retention in days for FlowLogs | `number` | `90` | no |
| enable\_classiclink | n/a | `bool` | `false` | no |
| enable\_classiclink\_dns\_support | n/a | `bool` | `false` | no |
| enable\_dns\_hostnames | n/a | `bool` | `false` | no |
| enable\_dns\_support | n/a | `bool` | `false` | no |
| have\_flowlogs | Enable FlowLogs (true/false) | `bool` | `false` | no |
| have\_kinesis\_stream | Enable Kinesis Data Stream for Flowlogs (true/false) | `bool` | `false` | no |
| have\_logging\_bucket | Force deployment of S3 logging bucket even if kinesis isn't deployed | `bool` | `false` | no |
| have\_nacl | Should deploy nacl (true/false) | `bool` | `false` | no |
| have\_nat\_gateways | Should allow private subnet to access internet through public subnets (true/false) | `bool` | `false` | no |
| have\_private\_subnets | Should deploy private subnet (true/false) | `bool` | `false` | no |
| have\_public\_subnets | Should deploy public subnet, deploy NAT Gateways too (true/false) | `bool` | `false` | no |
| have\_vpc\_peering | Should deploy a VPC peering (true/false) | `bool` | `false` | no |
| have\_vpn\_connections | Should deploy vpn connections (true/false) | `bool` | `false` | no |
| instance\_tenancy | Default instance tenancy for EC2 launched inside the VPC | `string` | `"default"` | no |
| is\_multi\_az | Use all az of the current region (true/false) | `bool` | `false` | no |
| logs\_complete\_expiration\_days | Number of days object finally expire in S3 | `number` | `90` | no |
| logs\_expiration\_glacier | Number of days before change S3 Storage Class to Glacier | `number` | `60` | no |
| logs\_expiration\_onezone | Number of days before change S3 Storage Class to One Zone IA | `number` | `30` | no |
| logs\_expiration\_standard | Number of days before change S3 Storage Class to Standard IA | `number` | `15` | no |
| module\_version | Current version of the module | `string` | `"v0.0.1"` | no |
| peer\_friendly\_name | List of peer name | `list(string)` | `[]` | no |
| peer\_owner\_ids | List of AWS Account ID of the peer | `list(string)` | `[]` | no |
| peer\_region | List of region for each vpc peer | `list(string)` | `[]` | no |
| peer\_vpc\_ids | List of all peer vpc id | `list(string)` | `[]` | no |
| plateform\_environment | Plateform environment (test/prod/...) | `any` | n/a | yes |
| plateform\_name | Name of the plateform | `any` | n/a | yes |
| region | AWS Region to use | `any` | n/a | yes |
| requester\_allow\_classic\_link\_to\_remote\_vpc | Allow vpc requester classic link on remote | `bool` | `false` | no |
| requester\_allow\_remote\_vpc\_dns\_resolution | Allow vpc requester dns resolution | `bool` | `false` | no |
| requester\_allow\_vpc\_to\_remote\_classic\_link | Allow vpc requester classic link from current vpc | `bool` | `false` | no |
| s3\_expiration\_enabled | Enable logs expiration in logging bucket | `bool` | `false` | no |
| static\_routes\_only | use static route | `list(string)` | `[]` | no |
| vpn\_client\_endpoint | All the public IP for each vpn client | `list(string)` | `[]` | no |
| vpn\_client\_name | All the name for each vpn client | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| internet\_gateway\_id | n/a |
| nat\_gateway\_ids | n/a |
| nat\_gateway\_ips | n/a |
| private\_rtb | n/a |
| private\_subnet\_ids | n/a |
| public\_rtb | n/a |
| public\_subnet\_ids | OUTPUT FROM SUBNETS MODULE |
| s3\_logging\_bucket\_arn | n/a |
| s3\_logging\_bucket\_dns | n/a |
| s3\_logging\_bucket\_name | OUTPUT FROM FLOWLOGS |
| s3\_policy | n/a |
| vpc\_id | OUTPUT FROM MAIN |
| vpc\_peering\_accept\_status | n/a |
| vpc\_peering\_id | OUTPUT FROM VPC\_PEERING |     

Made with :heart: and :coffee: