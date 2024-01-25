# How to run it
# . .\30_pwnACL.ps1 -Domain "eu.local"

#Note 
#Domain eu.local should be resolveable 
#try running nslookup and see if there's a valid IP response

#Useful output
#Following means, USERAcct mgmtadmin has GW on computer US-HELPDESK
#So .... RBCD Attack ;-) 

#ObjectDN                                                                  ActiveDirectoryRights IdentityReferenceName
#--------                                                                  --------------------- ---------------------
#CN=US-HELPDESK,CN=Computers,DC=us,DC=techcorp,DC=local ListChildren, ReadProperty, GenericWrite mgmtadmin


param(
    [string]$Domain
)

# Check if the Domain parameter is provided
if (-not $Domain) {
    Write-Host "Please provide the domain as a command-line parameter."
    exit 1
}

# Assuming powerview.ps1 is in the same directory as this script
$PowerViewPath = "$PSScriptRoot\powerview.ps1"

# Load PowerView module
Write-Host "Loading PowerView module from: $PowerViewPath"
try {
    . $PowerViewPath
    Write-Host "PowerView module loaded successfully."
} catch {
    Write-Host "Error loading PowerView module: $_"
    exit 1
}

# Get information about all domain users (excluding Administrator, krbtgt, and guest)
$AllDomainUsers = Get-NetUser -Domain $Domain | Where-Object { $_.SamAccountName -notin @('Administrator', 'krbtgt', 'guest') }

# Iterate through each user and run the script
foreach ($User in $AllDomainUsers) {
    Write-Host "Running for user: $($User.SamAccountName)"

    # Retrieve results for the current user
    $UserResults = Find-InterestingDomainAcl -ResolveGUIDS -Domain $Domain | `
        Select-Object ObjectDN, ActiveDirectoryRights, IdentityreferenceName | `
        Where-Object -Property IdentityreferenceName -eq $User.SamAccountName

    # Display results for the current user
    $UserResults | Format-Table -AutoSize

    # Optionally, you can add a small delay between users if needed
    Start-Sleep -Seconds 1
}
