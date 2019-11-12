# TECHNICAL_DOCUMENTATION

# SUMMARY
- [TECHNICAL_DOCUMENTATION](#technicaldocumentation)
- [SUMMARY](#summary)
- [Variables](#variables)
- [Conditional_Deployment](#conditionaldeployment)
- [Outputed_resources](#outputedresources)


# Variables

|             Variable                      |                                  Description                                 | Has default value | Must set? |   |
|:-----------------------------------------:|:----------------------------------------------------------------------------:|:-----------------:|:---------:|:-:|
|              region                       |                             AWS Region to deploy                             |         no        |    yes    |   |
|          module_version                   |                               Version du module                              |       v0.0.1      |     no    |   |
|          plateform_name                   |                             Nom de la plateforme                             |         no        |    yes    |   |
|       plateform_environment               |                                  Environment                                 |         no        |    yes    |   |
|            cidr_block                     |                            CIDR block pour le VPC                            |         no        |    yes    |   |
|         instance_tenancy                  |                        Type d'ec2 a lancer dans le VPC                       |      default      |     no    |   |
|        enable_classiclink                 |                             Activer classic link                             |       false       |     no    |   |
|  enable_classiclink_dns_support           |                   Activer le support dns pour classic link                   |       false       |     no    |   |
|       enable_dns_hostnames                |                       Activer la resolution DNS interne                      |       false       |     no    |   |
|        enable_dns_support                 |                       Activer la resolution DNS interne                      |       false       |     no    |   |
| assign_generated_ipv6_cidr_block          |                    Activer la resolution IPv6 dans le VPC                    |       false       |     no    |   |
|        have_public_subnets                |                         Deploiement de subnets public                        |       false       |     no    |   |
|       have_private_subnets                |                         Deploiement de subnets prive                         |       false       |     no    |   |
|         have_nat_gateways                 |                          Deploiement de NAT Gateways                         |       false       |     no    |   |
|       have_vpn_connections                |                         Deploiement de connexion VPN                         |       false       |     no    |   |
|         have_vpc_peering                  |                         Deploiement d'un vpc peering                         |       false       |     no    |   |
|             have_nacl                     |                          Deploiement de Network acl                          |       false       |     no    |   |
|           have_flowlogs                   |                       Deploiement des flowlogs reseaux                       |       false       |     no    |   |
|        have_kinesis_stream                |            Deploiement d'un kinesis data stream pour les flowlogs            |       false       |     no    |   |
|       s3_expiration_enable                |           Activer l'expiration des objets S3 pour le bucket de log           |       false       |     no    |   |
|     logs_expiration_standard              | Nombre de jours avant de passer les objets dans le bucket log en standard_ia |         15        |     no    |   |
|      logs_expiration_onezone              |  Nombre de jours avant de passer les objets dans le bucket log en onezone_ia |         30        |     no    |   |
|      logs_expiration_glacier              |   Nombre de jours avant de passer les objets dans le bucket log en glacier   |         60        |     no    |   |
|   logs_complete_expiration_days           |       Nombre de jours avant de supprimer les objets dans le bucket log       |         90        |     no    |   |
|       cwl_retention_in_days               |           Nombre de jours de conservation des logs dans cloudwatch           |         90        |     no    |   |
|            is_multi_az                    |                        Deploiement sur toutes les AZs                        |       false       |     no    |   |
|        have_logging_bucket                |       Forcer le deploiement du bucket S3 si on ne deploie pas kinesis        |       false       |     no    |   |
|        vpn_client_name                    |       List of all vpn client named                                           |       []          |     no    |   |
|        vpn_client_endpoint                |       List public IP endpoint of each vpn client named                       |       []          |     no    |   |
|        have_vpc_peering                   |       Deploy VPC Peering on the fresh created VPC                            |       false       |     no    |   |
|        peer_owner_ids                     |       List of all peer aws account id to connect through peering             |       []          |     no    |   |
|        peer_vpc_ids                       |       List of all peer vpc id to connect through peering                     |       []          |     no    |   |
|        peer_region                        |       List of all peer vpc region to connect through peering                 |       []          |     no    |   |
| accepter_allow_remote_vpc_dns_resolution  |       Allow DNS resolution on peered vpc                                     |       false       |     no    |   |
| accepter_allow_classic_link_to_remote_vpc |       Allow classic link on remote vpc                                       |       false       |     no    |   |
| accepter_allow_vpc_to_remote_classic_link |       Allow classic link on current vpc                                      |       false       |     no    |   |
| requester_allow_remote_vpc_dns_resolution |       Allow DNS resolution on current vpc                                    |       false       |     no    |   |
| requester_allow_classic_link_to_remote_vpc|       Allow classic link on current vpc                                      |       false       |     no    |   |
| requester_allow_vpc_to_remote_classic_link|       Allow current vpc on remote classic link                               |       false       |     no    |   |



# Conditional_Deployment
Les variables suivante sont soumise a un déploiment conditionel :

 - is_multi_az
    - true  : Utilise toutes les azs disponible dans la région utilisée
    - false : Utilise uniquement une seule zone
  
 - have_public_subnets
    - true  : Déploie autant de subnets que d'azs en /24 (si le cidr du vpc et en /16) avec leurs routes tables, une internet gateway et configure une default route vers l'internet gateway
    - false : Ne déploie pas les  subnets, pas de route table et pas d'internet gateway 
  
 - have_private_subnets
    - true  : Déploie autant de subnet que d'azs en /24 (si le cidr du vpc et en /16) avec leurs route tables
    - false : Ne déploie aucune resources
  
 - have_nat_gateways
    - true  : Déploie autant de NAT Gateways que d'azs et ajoute une route sur toutes les routes tables privée 1 NAT pour 1 subnet pour 1 az
    - false : Ne déploie aucune resources
  
 - have_vpn_connections
    - true  : Deploy AWS Managed VPN connections
    - false : Do nothing  
  
 - have_vpc_peering 
    - true  : Deploy VPC Peering connections between current account and peer account
    - false : Do nothing 
  
 - have_nacl
    - NOT IMPLEMENTED 
  
 - s3_expiration_enable
    - true  : Active les regles de lifecycle sur le bucket de logging
    - false : Les regles ne sont pas actives
  
 - have_logging_bucket
    - true  : Force le deploiement d'un bucket S3 de logging meme si on ne deploie pas kinesis (Utile si have_kinesis_stream et have_flowlogs sont a false)
    - false : Ne déploie pas le bucket sauf si et seulement si have_kinesis_stream et have_flowlogs sont a true
  
 - have_flowlogs 
    - true  : Déploie les VPC flowlogs dans un cloudwatch loggroup avec une politique de retention dans cloudwatch
    - false : Ne déploie pas les resources
  
 - have_kinesis_stream
    - true  : Déploie un kinesis data stream et une log subscription sur les loggroup flowlogs pour envoyer les logs dans S3 via une lambda
    - false : Ne déploie pas les resources 

# Outputed_resources

Each created resources is outputed only and only if there is something to output however it'll ouput an empty list
