### Check if domain (user full email id) is using Azure tenant ? [Powershell method]

```
$User = "fowz@quantumsecurity.co.nz"
$URL = "https://login.microsoftonline.com/getuserrealm.srf?login=$User"
Invoke-RestMethod -Method Get -Uri $URL
```
#### Following is the valid reponse

```
State                  : 4
UserState              : 1
Login                  : fowz@quantumsecurity.co.nz
NameSpaceType          : Managed
DomainName             : quantumsecurity.co.nz
FederationBrandName    : Quantum Security Services
CloudInstanceName      : microsoftonline.com
CloudInstanceIssuerUri : urn:federation:MicrosoftOnline
```

#### Following is the invalid reponse

```
State UserState Login                            NameSpaceType
----- --------- -----                            -------------
    4         1 fowz@quantumsecurity1111.co.nz Unknown      
```

### Check if domain (user full email id) is using Azure tenant ? [AAD Internals method]

```
Set-ExecutionPolicy -Scope "CurrentUser" -ExecutionPolicy "RemoteSigned"
#Get-ExecutionPolicy
Import-Module C:\Tools\AADInternals-master\AADInternals.psd1
Get-AADIntLoginInformation -UserName 'fowz@quantumsecurity.co.nz'
```

#### Following is the valid reponse

```
Has Password                         : True
Federation Protocol                  : 
Pref Credential                      : 1
Consumer Domain                      : 
Cloud Instance audience urn          : urn:federation:MicrosoftOnline
Authentication Url                   : 
Throttle Status                      : 0
Account Type                         : Managed
Federation Active Authentication Url : 
Exists                               : 0
Federation Metadata Url              : 
Desktop Sso Enabled                  : 
Tenant Banner Logo                   : 
Tenant Locale                        : 
Cloud Instance                       : microsoftonline.com
State                                : 4
Domain Type                          : 3
Domain Name                          : quantumsecurity.co.nz
Tenant Banner Illustration           : 
Federation Brand Name                : Quantum Security Services
Federation Global Version            : 
User State                           : 1
```
> Exists = 0 (user present) Exists = 1 (user not present)

### Retrive Tenant ID ? [Powershell method]

```
$Domain = "quantumsecurity.co.nz"
$URL = "https://login.microsoftonline.com/$Domain/.well-known/openid-configuration"
Invoke-RestMethod -Method Get -Uri $URL
```

#### Following is the invalid reponse

```
token_endpoint                        : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/oauth2/token
token_endpoint_auth_methods_supported : {client_secret_post, private_key_jwt, 
                                        client_secret_basic}
jwks_uri                              : https://login.microsoftonline.com/common/discover
                                        y/keys
response_modes_supported              : {query, fragment, form_post}
subject_types_supported               : {pairwise}
id_token_signing_alg_values_supported : {RS256}
response_types_supported              : {code, id_token, code id_token, token 
                                        id_token...}
scopes_supported                      : {openid}
issuer                                : https://sts.windows.net/e51ee1a6-e3fa-4fb6-9424-0
                                        e022c6abe61/
microsoft_multi_refresh_token         : True
authorization_endpoint                : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/oauth2/authorize
device_authorization_endpoint         : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/oauth2/devicecode
http_logout_supported                 : True
frontchannel_logout_supported         : True
end_session_endpoint                  : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/oauth2/logout
claims_supported                      : {sub, iss, cloud_instance_name, 
                                        cloud_instance_host_name...}
check_session_iframe                  : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/oauth2/checksession
userinfo_endpoint                     : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/openid/userinfo
kerberos_endpoint                     : https://login.microsoftonline.com/e51ee1a6-e3fa-4
                                        fb6-9424-0e022c6abe61/kerberos
tenant_region_scope                   : OC
cloud_instance_name                   : microsoftonline.com
cloud_graph_host_name                 : graph.windows.net
msgraph_host                          : graph.microsoft.com
rbac_url                              : https://pas.windows.net
```

### Retrive Tenant ID ? [AAD Internals method]

```
Set-ExecutionPolicy -Scope "CurrentUser" -ExecutionPolicy "RemoteSigned"
#Get-ExecutionPolicy
Import-Module C:\Tools\AADInternals-master\AADInternals.psd1
Get-AADIntTenantID -Domain quantumsecurity.co.nz
```
#### Following is the valid reponse

```
e51ee1a6-e3fa-4fb6-9424-0e022c6abe61
```

### Retrive All The Domains Present In the AZ Tenant ? [AAD Internals method]

```
Set-ExecutionPolicy -Scope "CurrentUser" -ExecutionPolicy "RemoteSigned"
#Get-ExecutionPolicy
Import-Module C:\Tools\AADInternals-master\AADInternals.psd1
Get-AADIntTenantDomains -Domain quantumsecurity.co.nz
```

#### Following is the valid reponse

```
nzbeta4.co.nz
qssl.nz
quantumsecnz.onmicrosoft.com
quantumsecurity.co.nz
quantumsecurity.nz
```

### Check if the user is valid ? [Powershell method]

```
$Username = "fowz@quantumsecurity.co.nz"
$URI = 'https://login.microsoftonline.com/common/GetCredentialType'
$RequestParams = @{
    Method = 'POST'
    Uri = $URI
    Body = @{
        'Username' = $Username
        } | ConvertTo-Json
        }
    $Result = Invoke-RestMethod @RequestParams

    if ($Result.IfExistsResult -eq 0)
    {Write-Output "$UserName is valid"}

    else
    {Write-Output "$Username is invalid"}
```

#### Following is the valid reponse

```
fowz@quantumsecurity.co.nz is valid
```

### Check if the Office365 is used ? [Powershell method]

```
$Username = "fowz@quantumsecurity.co.nz"
$URI = "https://outlook.office365.com/autodiscover/autodiscover.json?Email=$UserName&Protocol=Autodiscoverv1"

$RequestParams = @{
Method = 'GET'
Uri = $URI}

Invoke-RestMethod @RequestParams
```

#### Following is the valid response

```
Protocol       Url                                                        
--------       ---                                                        
Autodiscoverv1 https://outlook.office365.com/autodiscover/autodiscover.xml
```
