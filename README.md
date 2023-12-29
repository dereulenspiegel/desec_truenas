# TrueNAS ACME DNS Authenticator Script for DeSEC

This is a shell script to use [DeSEC](https://desec.io) for the DNS-01 challenge
of ACME based CAs with TrueNAS.

## Usage

* Replace the value of `DESEC_TOKEN` with an actual token with the permission to create and delete records
* Set `OVERRIDE_DOMAIN` to the domain managed by deSEC in which the records will be created
* Copy the script to a pool on your TrueNAS server. Ensure that the dataset in the pool has the permission
  to execute scripts
* Use the script under Credentials > ACME DNS Authenticators > Shell
* Create ACME based certificates as described [here](https://www.truenas.com/docs/scale/scaletutorials/credentials/certificates/settingupletsencryptcertificates/)
