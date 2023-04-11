variable ad_controller_public_ip {
  description = "The public IP address of the AD controller"
  type        = string
}


variable windows_password {
  description = "The password for the Windows VM.  You'll need to get this from the AWS portal."
  type        = string
  default     = "q$80@?8$j9oCW=&A8X!ZtFAnj)Acat&z"
}