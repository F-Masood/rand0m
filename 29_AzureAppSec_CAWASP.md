#### Check if domain (user full email id) exists on Azure ?

```
$User = "fowz@quantumsecurity.co.nz"
$URL = "https://login.microsoftonline.com/getuserrealm.srf?login=$User"
Invoke-RestMethod -Method Get -Uri $URL
```
