variable "project" {
  default = "lab-4-319822"
}

variable "region" {
  default = "us-central1"
}

variable "credentials" {
  default = "./key.json"
}

variable "ansible_pub_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqxrwHUdSCpC3LgADaP93nB/Duh3gayAjGA8uncVL5RN5EBzH2r1zGLxIFTHrbHATGtNoXKNF1XFujB6WxSQ9qefO5OkoxZzSQ31pcv1yIjpM9hBG4VH07ZQVJeogkQx1illONSFxH9mVRzULUl325ueoNnXyfXXqbNX8l+2ooJPaAOkXmV4xCAvkP5eE6Kft9N5riHDktFTtiGBCOsmD/prpczKtQwJb3PczpkCOL+jdTW97ebLpm6zfBrCqsjnYQ39fTvUiaF5HpfFJpkUYcHGVukIwvM8TQjWX/yccUdHfr7LVWi0yF/lKfjXYb67Oqz66dbcype2zvicNtZNE1GRyDFPjUtStKtt+Lx9HkCVrkXJR/hZtuYWW+uG1erq7JD0ZVsXd0FvYhZxVv7lZFqUSk9Kn17+rBa00kVoARoS6EHsdW3cO+VME5oFGxaqqBt2cSuqbxqo2qU3LBwqkCAQFSmdi+PO/sY7DXriA36myA/VjmxlJcTqIfChsVv9s= ansible@ansible"
}

variable "ansible_user" {
  default = "a_styler"
}

variable "ansible_vault_pass" {
  description = "Please enter password for Ansible Vault"
  type        = string
}