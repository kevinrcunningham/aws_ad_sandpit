# ADSandpit
A quick and dirty single Domain Controller (DC) isolated sandpit Active Directory (AD) environment for AWS.  

_NOTE THAT THIS IS NOT SUITABLE FOR ANY PRODUCTION ENVIRONMENT.  THE PURPOSE OF THIS CODE IS TO PROVIDE A SANDPIT ENVIRONMENT FOR HIGH LEVEL PROOF OF CONCEPT TESTING ONLY._

_ALWAYS DESTROY YOUR TERRAFORMED INFRASTRUCTURE WHEN IT IS NO LONGER IN USE TO PREVENT ACCUMULATION OF UNEXPECTED AWS BILLS.  THE EC2 INSTANCE TYPE USED IN THIS CODE IS NOT ELIGIBLE FOR AWS FREE TIER USE AND DOES CARRY A SMALL HOURLY COST.  AMEND THE DC\_INSTANCE\_TYPE VARIABLE TO CHOOSE A FREE TIER OPTION IF REQUIRED._

Environment comprises of:
  *  A VPC
  *  2 subnets (one in each of two Availability Zones)
  *  A security group to allow access to the domain controller on any port from within the VPC, and from the internet via RDP
  *  An internet gateway attached to the VPC to allow a public address to be assigned to the DC
  *  A route to the internet gateway added to the routing table for public IP addresses
  *  A single Windows 2019 server running AD DS and promoted as a single forest, single domain, and single domain controller instance running Windows integrated DNS and pointing to itself for name resolution

The DC is designed to have a public IP address and so double as a bastion server (via RDP) for the sandpit environment.  Access to any further resources within the sandpit can then be gained via RDP or OpenSSH from the DC.

Any further instances created to interact with this environment will need to point to the domain controller for DNS resolution.

#### Additional Info

AD properties are contained in the userdata.txt file which is a short powershell script to create an admin user, install AD DS, and promote the server as a DC. These are static entries within the file, which cannot contain variables.  To alter the user name, password, or domain name, edit the appropriate lines of text.

Default values contained in the file are:
    Domain FQDN:    ADSandpit.net
    Admin User:     ADSandpitAdmin
    Password:       Password1

This user is created as a member of the local administrators group prior to promotion, and is therefore a member of ADSandpit\Administrators upon promotion.  For additional access (Domain Admins, etc) this must be configured after creation.

A public IP address is assigned to the instance and this can be read from the AWS console and used to connect via RDP.  Please allow several minutes after the EC2 instance has initialised for services to start and login to proceed.

#### Usage

The files in this repository are for use with terraform.  The files generated by terraform itself are ignored (see .gitignore file).

One additional file which is also ignored must be created to hold the AWS access key and access secret variables.  These must be declared as access_key and access_secret and contained in awscreds.tf (this file will also be ignored by git).

For details on the use of terraform with the AWS provider, please see HashiCorp documentation at https://www.terraform.io/docs/providers/aws/index.html