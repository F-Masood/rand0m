##### Author: skinny3l3phant
###### Date: 31 Dec 2020
###### Challenge name: ZIP ZIP - 50 points
###### Wesbite: https://grimmcon.ctf.games/challenges
###### Made in: Python3
###### OS: KaliLinux 2020.1

> 1. To run this script type: python3 <this script name>
> 1.                  e.g:  python3 fiftyZipExtractor.py
> 1.                  Note: Make sure this python script and 50.zip file are in the same directory


```python
from zipfile import ZipFile
import time


counter = 50 #Because given filenanme is 50.zip
str_pwd= 'pass' #Password to extract the ZIP files
filename = ""

print("*** 50 ZIP ( ͡°( ͡° ͜ʖ( ͡° ͜ʖ ͡°)ʖ ͡°) ͡°) Extractor***\n")

while counter >= 0:
    print ("Now, I will extract file = "+str(counter)+".zip")
    if counter >= 10:
        filename = str(counter)+".zip"
    elif counter < 10:
        filename = "0"+str(counter)+".zip"
    
    str_zipFile = filename
    

    with ZipFile(str_zipFile) as zipObj:
        zipObj.extractall(pwd = bytes(str_pwd,'utf-8'))
        time.sleep(.5)
        counter = counter - 1 

print("*** THE END ***")
```

