**Dated:** 16 Jan 2021

**Solution** for the **Twirl** linux box -  I made for **HackMyVM** site ~ Made and tested in VMWare Workstation Pro
> 1. Avoid rabbit holes
> 1. Open web browser and go to .git file, at the bottom it says there is a website hosted called **superweb.com** and the word **TWIRL** is mentioned
> 1. Add this **superweb.com** to your linux OS (e.g. lets say you have Kali Linux as OS) */etc/hosts* file
> 1. On kali box, open superweb.com
> 1. On the right side of that picture, URL "photopea.com" is mentioned
> 1. Open the photopea.com website (or you can try in Photoshop or Gimp etc.) 
> 1. Load this image to the website. Select the area in which letters are twisted
> 1. Go to **Filter** -> **Distort** -> and select **TWIRL**
> 1. Drag the ANGLE BAR to left (approx value -230). Now you can read the distorted words easily
> 1. You have the creds of the username "skinnysec" and his password
> 1. Login as skinnysec user via SSH on port 30
> 1. inside /home/skinny folder there is a file called .bash_profile. On line 958 of there is a string. Decode this string with base64 two times. You now have the password of user el3phant; switch to user el3phant. 
> 1. Inside the /home dir of el3phant, there is a folder called **...**. Before going in, change its permission to chmod 777 ... (and then get into the folder ...) 
> 1. Go inside it and again there is another folder called ...
> 1. Read the **user.txt** flag
> 1. There is a folder called mysimplemathsgame. Play/run the game, answer 03 maths questions correctly and a BIND SHELL as root on some random TCP port will open. 
> 1. From Kali Box simply connect to that port with nc. eg. nc <ip> <port told by the game>
> 1. you are now root, read the root flag. 
