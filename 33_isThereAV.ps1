### powershell conversion of https://github.com/nand0san/av_detect/tree/main (av_detect.exe)
$SecuritySoftwareProcesses = 
@{
     <# Just for test purposes
     /*
     "notepad" = 
    @{
        "name" = "Notepad"
        "type" = "The good old MS notepad is running ^_^ - Nothing malicious, just for testing purposes"
    } #>

"aciseagent" = @{
    "name" = "Cisco Umbrella Roaming Security"
    "type" = "Security DNS"
}
"acnamagent" = @{
    "name" = "Absolute Persistence"
    "type" = "Asset Management"
}
"acnamlogonagent" = @{
    "name" = "Absolute Persistence"
    "type" = "Asset Management"
}
"acumbrellaagent" = @{
    "name" = "Cisco Umbrella Roaming Security"
    "type" = "Security DNS"
}
"agmservice" = @{
    "name" = "Adobe"
    "type" = "Telemetry"
}
"agsservice" = @{
    "name" = "Adobe"
    "type" = "Telemetry"
}
"appcontrolagent" = @{
    "name" = "Application Control"
    "type" = "Trend Micro"
}
"aswidsagent" = @{
    "name" = "AV"
    "type" = "Avast"
}
"avastsvc" = @{
    "name" = "AV"
    "type" = "Avast"
}
"avastui" = @{
    "name" = "AV"
    "type" = "Avast"
}
"avgnt" = @{
    "name" = "AV"
    "type" = "Avira"
}
"avguard" = @{
    "name" = "AV"
    "type" = "Avira"
}
"avp" = @{
    "name" = "AV"
    "type" = "Kaspersky"
}
"avpui" = @{
    "name" = "AV"
    "type" = "Kaspersky"
}
"axcrypt" = @{
    "name" = "AxCrypt"
    "type" = "Encryption"
}
"bdagent" = @{
    "name" = "AV"
    "type" = "Bitdefender Total Security"
}
"bdntwrk" = @{
    "name" = "AV"
    "type" = "Bitdefender"
}
"browserexploitdetection" = @{
    "name" = "Exploit Detection"
    "type" = "Trend Micro"
}
"carbonsensor" = @{
    "name" = "EDR"
    "type" = "VMware Carbon Black EDR"
}
"cbcomms" = @{
    "name" = "CrowdStrike Falcon Insight XDR"
    "type" = "XDR"
}

"ccsvchst" = @{
    "name" = "AV"
    "type" = "Symantec Endpoint Protection"
}
"clientcommunicationservice" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"clientlogservice" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"clientsolutionframework" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"cmrcservice" = @{
    "name" = "Microsoft Configuration Manager Remote Control Service"
    "type" = "Remote Control"
}
"concentr" = @{
    "name" = "Palo Alto Networks GlobalProtect"
    "type" = "VPN"
}
"coreserviceshell" = @{
    "name" = "AV"
    "type" = "Trend Micro"
}
"cpd" = @{
    "name" = "Check Point Daemon"
    "type" = "Security"
}
"cpx" = @{
    "name" = "SentinelOne Singularity XDR"
    "type" = "XDR"
}
"csfalconcontainer" = @{
    "name" = "CrowdStrike Falcon"
    "type" = "EDR"
}
"csfalcondaterepair" = @{
    "name" = "CrowdStrike Falcon"
    "type" = "EDR"
}
"csfalconservice" = @{
    "name" = "CrowdStrike Falcon Insight XDR"
    "type" = "XDR"
}
"cybereason" = @{
    "name" = "Cybereason EDR"
    "type" = "EDR"
}
"cytomicendpoint" = @{
    "name" = "Cytomic Orion"
    "type" = "Security"
}
"cyveraconsole" = @{
    "name" = "EDR"
    "type" = "Palo Alto Networks (Cyvera)"
}
"cyveraservice" = @{
    "name" = "EDR"
    "type" = "Palo Alto Networks (Cortex XDR)"
}
"cyvragentsvc" = @{
    "name" = "EDR"
    "type" = "Palo Alto Networks (Cortex XDR)"
}
"cyvrfsflt" = @{
    "name" = "EDR"
    "type" = "Palo Alto Networks (Cortex XDR)"
}
"darktracetsa" = @{
    "name" = "Darktrace"
    "type" = "EDR"
}
"dataprotectionservice" = @{
    "name" = "Data Protection"
    "type" = "Trend Micro"
}
"dlpagent" = @{
    "name" = "DLP"
    "type" = "Symantec DLP Agent"
}
"dlpsensor" = @{
    "name" = "DLP"
    "type" = "McAfee DLP Sensor"
}
"dsmonitor" = @{
    "name" = "DriveSentry"
    "type" = "Security"
}
"dwengine" = @{
    "name" = "DriveSentry"
    "type" = "Security"
}
"edpa" = @{
    "name" = "AV"
    "type" = "McAfee Endpoint Security"
}
"eegoservice" = @{
    "name" = "Encryption"
    "type" = "McAfee Endpoint Encryption"
}
"egui" = @{
    "name" = "AV"
    "type" = "ESET NOD32 AV"
}
"ekrn" = @{
    "name" = "AV"
    "type" = "ESET NOD32 AV"
}
"endpointbasecamp" = @{
    "name" = "EDR"
    "type" = "Trend Micro"
}
"firesvc" = @{
    "name" = "FireEye Endpoint Agent"
    "type" = "Security"
}
"firetray" = @{
    "name" = "FireEye Endpoint Agent"
    "type" = "Security"
}
"fortiedr" = @{
    "name" = "EDR"
    "type" = "FortiEDR"
}
"fw" = @{
    "name" = "Check Point Firewall"
    "type" = "Firewall"
}
"healthservice" = @{
    "name" = "Microsoft OMS"
    "type" = "Monitoring"
}
"hips" = @{
    "name" = "HIPS"
    "type" = "Host Intrusion Prevention System"
}
"klwtblfs" = @{
    "name" = "AV"
    "type" = "Kaspersky"
}
"klwtpwrs" = @{
    "name" = "AV"
    "type" = "Kaspersky"
}
"kpf4ss" = @{
    "name" = "Firewall"
    "type" = "Kerio Personal Firewall"
}
"ksde" = @{
    "name" = "Kaspersky Secure Connection"
    "type" = "VPN"
}
"ksdeui" = @{
    "name" = "Kaspersky Secure Connection"
    "type" = "VPN"
}
"macmnsvc" = @{
    "name" = "AV"
    "type" = "McAfee Endpoint Security"
}
"masvc" = @{
    "name" = "AV"
    "type" = "McAfee Endpoint Security"
}
"mbae64" = @{
    "name" = "AV"
    "type" = "Malwarebytes"
}
"mbamservice" = @{
    "name" = "AV"
    "type" = "Malwarebytes"
}
"mbamswissarmy" = @{
    "name" = "AV"
    "type" = "Malwarebytes"
}
"mbamtray" = @{
    "name" = "AV"
    "type" = "Malwarebytes"
}
"mcshield" = @{
    "name" = "AV"
    "type" = "McAfee VirusScan"
}
"mdecryptservice" = @{
    "name" = "Encryption"
    "type" = "McAfee Endpoint Encryption"
}
"mdnsresponder" = @{
    "name" = "Bonjour Service"
    "type" = "Network Service"
}
"mfeann" = @{
    "name" = "AV"
    "type" = "McAfee"
}
"mfeepehost" = @{
    "name" = "Encryption"
    "type" = "McAfee Endpoint Encryption"
}
"mfefire" = @{
    "name" = "HIPS"
    "type" = "McAfee Host Intrusion Prevention"
}
"mfemactl" = @{
    "name" = "Firewall"
    "type" = "McAfee Endpoint Security Firewall"
}
"mfemms" = @{
    "name" = "AV"
    "type" = "McAfee"
}
"monitoringhost" = @{
    "name" = "Microsoft Monitoring Agent"
    "type" = "Monitoring"
}
"msascuil" = @{
    "name" = "AV"
    "type" = "Windows Defender"
}
"msmpeng" = @{
    "name" = "AV"
    "type" = "Windows Defender"
}
"msseces" = @{
    "name" = "AV"
    "type" = "Microsoft Security Essentials"
}
"mssense" = @{
    "name" = "Microsoft Defender ATP (Advanced Threat Protection)"
    "type" = "Security"
}
"nissrv" = @{
    "name" = "AV Network Inspection"
    "type" = "Microsoft Security Essentials"
}
"nortonsecurity" = @{
    "name" = "AV"
    "type" = "Norton Antivirus"
}
"npmdagent" = @{
    "name" = "Network Monitoring"
    "type" = "SolarWinds NPM"
}
"ns" = @{
    "name" = "AV"
    "type" = "Norton Antivirus"
}
"nsservice" = @{
    "name" = "AV"
    "type" = "Norton Antivirus"
}
"openvpnserv" = @{
    "name" = "OpenVPN"
    "type" = "VPN"
}
"outpost" = @{
    "name" = "Agnitum Outpost Firewall"
    "type" = "Firewall"
}
"panda_url_filtering" = @{
    "name" = "AV"
    "type" = "Panda Security"
}
"pangps" = @{
    "name" = "Palo Alto Networks GlobalProtect"
    "type" = "VPN"
}
"pavfnsvr" = @{
    "name" = "AV"
    "type" = "Panda Security"
}
"pavsrv" = @{
    "name" = "AV"
    "type" = "Panda Security"
}
"personalfirewallservice" = @{
    "name" = "Firewall"
    "type" = "Trend Micro"
}
"psanhost" = @{
    "name" = "AV"
    "type" = "Panda Security"
}
"realtimescanservice" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"rtvscan" = @{
    "name" = "AV"
    "type" = "Symantec Endpoint Protection"
}
"samplingservice" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"savservice" = @{
    "name" = "AV"
    "type" = "Sophos Endpoint Security"
}
"sbiesvc" = @{
    "name" = "Sandboxie"
    "type" = "Security"
}
"securityagentmonitor" = @{
    "name" = "Antivirus/EDR"
    "type" = "Trend Micro"
}
"securityhealthservice" = @{
    "name" = "Security"
    "type" = "Windows Security Health Service"
}
"sentinel" = @{
    "name" = "EDR"
    "type" = "Unknown (Potential: Microsoft Defender)"
}
"sentinelagent" = @{
    "name" = "EDR"
    "type" = "SentinelOne"
}
"sentinelctl" = @{
    "name" = "EDR"
    "type" = "SentinelOne"
}
"shstat" = @{
    "name" = "AV"
    "type" = "McAfee VirusScan"
}
"smsvchost" = @{
    "name" = "Application"
    "type" = "Microsoft .NET Framework"
}
"sophosav" = @{
    "name" = "AV"
    "type" = "Sophos Endpoint Security"
}
"sophosclean" = @{
    "name" = "AV"
    "type" = "Sophos"
}
"sophoshealth" = @{
    "name" = "AV"
    "type" = "Sophos"
}
"sophossps" = @{
    "name" = "AV"
    "type" = "Sophos Endpoint Security"
}
"sophosui" = @{
    "name" = "AV"
    "type" = "Sophos Endpoint Security"
}
"sysmon" = @{
    "name" = "Microsoft Sysmon"
    "type" = "Security"
}
"sysmon64" = @{
    "name" = "Microsoft Sysmon"
    "type" = "Security"
}
"tanclient" = @{
    "name" = "EDR"
    "type" = "Tanium EDR"
}
"telemetryagentservice" = @{
    "name" = "Telemetry"
    "type" = "Trend Micro"
}
"telemetryservice" = @{
    "name" = "Telemetry"
    "type" = "Unknown"
}
"tmntsrv" = @{
    "name" = "AV"
    "type" = "Trend Micro OfficeScan"
}
"tmproxy" = @{
    "name" = "AV"
    "type" = "Trend Micro OfficeScan"
}
"traps" = @{
    "name" = "EDR"
    "type" = "Palo Alto Networks (Cortex XDR)"
}
"trapsagent" = @{
    "name" = "Palo Alto Networks Cortex XDR"
    "type" = "XDR"
}
"trapsd" = @{
    "name" = "Palo Alto Networks Cortex XDR"
    "type" = "XDR"
}
"truecrypt" = @{
    "name" = "Encryption"
    "type" = "TrueCrypt"
}
"uiwinmgr" = @{
    "name" = "AV"
    "type" = "Trend Micro"
}
"updatesrv" = @{
    "name" = "AV"
    "type" = "Bitdefender"
}
"vgauthservice" = @{
    "name" = "VMware"
    "type" = "Virtualization"
}
"vm3dservice" = @{
    "name" = "VMware"
    "type" = "Virtualization"
}
"vmtoolsd" = @{
    "name" = "VMware"
    "type" = "Virtualization"
}
"vpnagent" = @{
    "name" = "Cisco AnyConnect Secure Mobility Client"
    "type" = "VPN"
}

"vpnui" = @{
    "name" = "Cisco AnyConnect"
    "type" = "VPN"
}
"vsserv" = @{
    "name" = "AV"
    "type" = "Bitdefender Total Security"
}
"vulnerabilityprotectionagent" = @{
    "name" = "Trend Micro"
    "type" = "Vulnerability Protection"
}
"windefend" = @{
    "name" = "AV"
    "type" = "Windows Defender"
}
"winlogbeat" = @{
    "name" = "Elastic Winlogbeat"
    "type" = "Security"
}
"wireguard" = @{
    "name" = "VPN"
    "type" = "WireGuard"
}
"wrsa" = @{
    "name" = "AV"
    "type" = "Webroot Anywhere"
}
"wscservice" = @{
    "name" = "Security Service"
    "type" = "Trend Micro"
}
"xagt" = @{
    "name" = "FireEye HX"
    "type" = "Security"
}

}

Function IsSecuritySoftwareRunning {
    $DetectedProcesses = @{}
    $Found = $false

    $Processes = Get-Process | Select-Object -ExpandProperty Name

    foreach ($Process in $Processes) {
        $LowerCaseProcessName = $Process.ToLower()

        if (-not $DetectedProcesses.ContainsKey($LowerCaseProcessName)) {
            if ($SecuritySoftwareProcesses.ContainsKey($LowerCaseProcessName)) {
                $Found = $true
                Write-Host "`n*** Security Software detected: $($SecuritySoftwareProcesses[$LowerCaseProcessName].name) ($($SecuritySoftwareProcesses[$LowerCaseProcessName].type)) - Process: $Process"
                $DetectedProcesses[$LowerCaseProcessName] = $true
            }
        }
    }

    return $Found
}

$Version = "v1.8 - Ported 2 Powershell`r`n"

Write-Host "AV_detect Version: $Version"

if (IsSecuritySoftwareRunning) {
    Write-Host "`nFound security software process (AV, anti-malware, EDR, XDR, etc.) running."
} else {
    Write-Host "`nNo security software processes (AV, anti-malware, EDR, XDR, etc.) were found running."
}
