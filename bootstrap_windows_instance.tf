# Bootstrapping PowerShell Script
data "template_file" "windows_ad" {
  template = <<EOF
<powershell>
# Install the necessary AD DS role and management tools
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Set up the domain and configure the AD Forest
$domainName = "${var.ad_domain_name}"
$netBIOSName = "${var.ad_netBIOS_name}"
$safeModePassword = "${var.ad_admin_password}"

# Convert the Safe Mode password to a Secure String
$secureSafeModePassword = ConvertTo-SecureString $safeModePassword -AsPlainText -Force

# Install the new Forest with the specified domain name and Safe Mode password
Install-ADDSForest `
  -CreateDnsDelegation:$false `
  -DatabasePath "C:\Windows\NTDS" `
  -DomainMode "Win2012R2" `
  -DomainName $domainName `
  -DomainNetbiosName $netBIOSName `
  -ForestMode "Win2012R2" `
  -InstallDns:$true `
  -LogPath "C:\Windows\NTDS" `
  -NoRebootOnCompletion:$false `
  -SysvolPath "C:\Windows\SYSVOL" `
  -Force:$true `
  -SafeModeAdministratorPassword $secureSafeModePassword

# The server will reboot automatically once the installation process is complete
</powershell>
EOF
}