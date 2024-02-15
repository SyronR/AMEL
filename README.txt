Welcome and thank you for using AMEL. Using this tool is extremely easy, 
since it has been designed so that anyone can use it.

It is a script that automates the task of extracting RAM from Linux devices 
with AVML. You can then create the profile for volatility so there is no 
problem when it comes to finding which profile best suits the RAM memory.

The program will dump the data into the 'capture' folder, which will be 
created automatically if it is not detected. It will also automatically 
install the dependencies necessary to create the memory profiles if they 
are not present, and once installed, they will no longer be checked to see 
if they are present.

Finally, note that AMEL will also create the 'volatilityrc' file that will 
contain the metadata of the files created automatically, so that you do not 
have to specify them when writing the commands. Just write 
"python2.7 vol.py linux_banner".

If you find any bugs or issues, let me know on my Github and I will try to 
resolve it as soon as possible. Thank you for using AMEL 
(Automated Memory Extractor for Linux).