#Demo of ZipCrypto vulnerablity

> 1. Create a zip folder -> **zip -e -r /dev/shm/unzipMe/mySecure.zip /home/fm/**
> 1. give password of -> **V3rY_$3c^-1**
> 1. List the zip files -> **7z l mySecure.zip**
> 1. List the Zip Encryption algorithm -> **7z l slt mySecure.zip**
> 1. Get some known file e.g. **.bashrc** and zip it to make **bashrc.zip**
> 1. Get keys -> **./bkcrack -C /dev/shm/unzipMe/mySecure.zip -c home/fm/.bashrc -P /dev/shm/unzipMe/bashrc.zip -p .bashrc**
> 1. Get keys -> **./bkcrack -C /dev/shm/mySecure2022_03_28-01_04_02_PM.zip -c 'home/fm/arbisoft-logo.png' -P /dev/shm/arbisoft-logo.png
.zip -p arbisoft-logo.png**
> 1. Find exact password -> **./bkcrack -k ab3fd279 cb16c405 8bf59195 -r 20 ?p**  
