variable ad_controller_public_ip {
  description = "The public IP address of the AD controller"
  type        = string
}
/*
variable ad_domain_name {
  description = "The domain name of the AD controller"
  type        = string
  default     = "mattygrecgrec.com"
}
*/

variable ad_container {
  description = "The container for the AD objects"
  type        = string
  default     = "OU=Users,DC=mattygrecgrec,DC=com"
}


variable ad_domain {
  description = "The domain of the AD controller"
  type        = string
  default     = "mattygrecgrec"
}

variable windows_password {
  description = "The password for the Windows VM.  You'll need to get this from the AWS portal."
  type        = string
  }

