### Check if domain (user full email id) exists on Azure ?

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
    4         1 fowz111@quantumsecu111rity.co.nz Unknown      
```
