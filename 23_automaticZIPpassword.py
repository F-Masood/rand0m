'''
This python script will password protect "/home/fm" directory with a random password.
Password protected ZIP folder will be placed in /dev/shm/ directory
Make it a every 2 minute cronjob by adding following:
*/2 * * * *  python3 /root/mybackup.py
'''

import string, random, os
from datetime import datetime

length = 11  #length of password 

lower = string.ascii_lowercase
upper = string.ascii_uppercase
num = string.digits
symbols = '@$%-=+_'

#symbols = string.punctuation
#print (type(symbols))
#print (symbols)

all = lower + upper + num + symbols

temp = random.sample(all,length)
password = "".join(temp) #here is final password 
#print (password)

timeIs = datetime.now().strftime("%Y_%m_%d-%I_%M_%S_%p")
fileName = 'mySecure_'+str(timeIs)+'.zip'

os.system('zip -r -P '+str(password)+' /dev/shm/mySecure'+str(timeIs)+'.zip /home/fm/')

#just some logging for trobule shooting
f = open("/dev/shm/cronLog", "a")
f.write("The file -> "+fileName+' was protected with password of => '+password+'\n')
f.close()

#print(password)
