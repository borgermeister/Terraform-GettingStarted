Generate an SSH key pair and add the public key file, terraform.pub, to this folder.

Azure in general doesn't support ed25519 keys, so you have to create an RSA key instead.

Default RSA key size, if not specified, is 3072-bits

Example:
ssh-keygen -f terraform -C Terraform