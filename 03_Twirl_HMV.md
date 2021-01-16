**Dated:** 16 Jan 2021

**Solution** for the **Twirl** linux box -  **HackMyVM** site ~ Made and tested in VMWare Workstation Pro
> 1. Avoid rabbit holes
> 1. Open web browser and go to .git file, at the bottom it says there is a website hosted called **superweb.com** and the word **TWIRL** is mentioned.
> 1. Add this *superweb.com* to your linux OS */etc/hosts* file
> 1. Extract it (script below)
> 1. Portknocking sequence revelaed (8721, 45000, 9191)
> 1. Enumerate the webserver (port 65,000)
> 1. Try running gobuster against it
> 1. Any useful directory found ??? (yes, found -> projects)
> 1. /projects/index.php (Upload Media Center)
> 1. What about arbitary file upload vulnerability for getting RCE / Rev Shell? (uploaded_files)
> 1. Exploit passwordstrength binary (location: /usr/bin/passwordStrengthApp.exe) and then overspill binary (/home/skinny/.reload)
> 1. Become root 
