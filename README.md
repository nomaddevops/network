# AWS NETWORK MODULE

## ABOUT
Terraform module to manage all network related on AWS. With this module you could deploy a basic network or a complex one.

You could manage all parameters related to VPC, and even more, VPN Connections (BGP and/or static), subneting, vpc peering connections and flowlogs of your vpc.


## FEATURES
Each features added is in a submodule, and use simple conditions to deploy or not the feature. (Example, I need avpn connections, I set have_vpn_connections to true)

## TERRAFORM VERSION
This module support only terraform 0.12 and above