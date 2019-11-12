# CHANGELOG

![changes](https://ageless-fitness.com/wp-content/uploads/2015/09/change.jpg "changes")

# SUMMARY

- [CHANGELOG](#changelog)
- [SUMMARY](#summary)
- [v1.0.0_a (JDU)](#v100a-jdu)
- [v1.0.0_b (JDU)](#v100b-jdu)
- [v1.0.0_c (JDU)](#v100c-jdu)
- [v1.0.0_d (JDU)](#v100d-jdu)
- [v1.0.0_e (JDU)](#v100e-jdu)
- [v2.0.0 (JDU)](#v200-jdu)


# v1.0.0_a (JDU)
 - Initial version
    - Complete README part without technical data
    - Initiate VPC creation
    - Create submodules folders
    - Prepare submodules definitions
    - Define/Configure default vars

# v1.0.0_b (JDU)
 - Init submodule subnets
    - public/private subnet creation
    - public/private route table creation
    - public/private default route
    - public/private route table association
    - Setting up conditionals deployement
    - Configure CIDRSubnet calcs

 - Init submodule vpn (Call module as much as you have client)
    - virtual private gateway creation
    - create vpn connections
    - create customers gateways
    - Setting up conditionals deployement

# v1.0.0_c (JDU)
 - Bug fixes on VPN creation
 - Adding FlowLogs modules in conditional deployment
    - Adding submodule kinesis_stream in FlowLogs to export flowlogs to s3 before cwl expire (Default: 7 Days)
    - Rewrite Flowlogs modules to simplify
    - Adding Kinesis stream and his lambda
    - Adding s3 logging module with default expire and no versionning
  
# v1.0.0_d (JDU)
 - VPN modules improvements
    - Multiple Client support

# v1.0.0_e (JDU)
 - VPC Peering
    - Init submodules
 - Add flowlogs output 

# v2.0.0 (JDU)
 - Migration du module vers terraform 0.12.3

Made with :heart: and :coffee:


