### Active Directory

#### How to identify alive hosts in netowrk ?
1. Run nmap ping sweep, Command: `nmap -r -sn 192.168.10.0/24'
2. Run nmap ping sweep, Command: `nmap -r -sP 192.168.10.0/24' 

#### How to identify Domain Controller (DC) ?
1. Most probably a DC would be having open PORTS e.g 53 and 88 which are not avbl to other Windows machines.
2. If you're in DC network, Command: `nmap -r -v --open -sC -sV -p53,88,389,636 <DC IP>`
3. If above command shows these ports **OPEN** ... You got **DC** !!!

#### Using impacket - To find all the usernames, email address etc?
1. Without username/password command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -dc-ip 192.168.110.55`
2. With user/password of a valid domain user command: `proxychains GetADUsers.py somedomain.htb/ -no-pass -all -dc-ip 192.168.110.55`
