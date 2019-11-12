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

     

Made with :heart: and :coffee: