#! /usr/bin/env python3.4
#
#$Author: ee364b06 $
#$Date: 2016-02-21 18:48:49 -0500 (Sun, 21 Feb 2016) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/S16/students/ee364b06/Prelab06/ip_detect.py $
#$Revision: 88518 $

import re
import sys
def ip_detect(filename):
    with open(filename,"r") as file:
        lines=file.readlines()
        for line in lines:
            ip=re.match(r"(\d+)\.(\d+)\.(\d+)\.(\d+)\:(.*)",line)
            flag=0
            line=line.strip("\n")
            for item in ip.group(1,2,3,4):
                if int(item) < 0 or int(item) >255:
                    print(line+" - " +"Invalid IP Address")
                    flag=1
                    break
            if ip.group(5).isdigit():

                if (int(ip.group(5))>32767 or int(ip.group(5))<1) and flag ==0:
                    flag=1
                    print(line+" - "+"Invalid Port Number")
                elif int(ip.group(5))<1024 and flag ==0:
                    flag=1
                    print(line+" - "+"Valid (root privileges required)")
            else:
                flag=1
                print(line+" - "+"Invalid Port Number")

            if flag == 0:
                print(line+" - "+"Valid")



if __name__ == '__main__':
    ip_detect(sys.argv[1])
