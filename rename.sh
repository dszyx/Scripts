#!/bin/bash

#### 大写改小写，这个是用来更改从 Linux 当中提取出来的SSDT 文件名的 ###

DIR=`find -type d | grep -E './*[A-Z].*' | awk 'BEGIN{FS="/"}{print $2}'`

#这里是查找当前目录下的所有包含了大写字母的目录
for file in $DIR 
do     
  mv $file `echo $file | tr 'A-Z' 'a-z'` #循环重命名目录，将大写全部转为小写
done 

# 批量更改扩展名
find .|sed 's/\.\///g'|sed 's/\.dat//g'|while read i; do mv $i.dat $i.aml; done
# 主文件名小写改大写
find .|sed 's/\.\///g'|sed 's/\.aml//g'|while read i; do mv $i.aml `echo $i|tr 'a-z' 'A-Z'`.aml ; done



##################### 蔣勳 - 細說紅樓夢 - 第27回下.mp3 ###########################
find .|sed 's/蔣勳//g'|sed 's/ //g'|sed 's/-//g'|sed 's/第//g'|sed 's/回//g'
#来看超级语句
ls|awk '{print "mv \""$0"\" "$5""}'|bash
#得到的文件名就是
#第27回下.mp3
#接下来写一段脚本

#!/bin/bash
for file in `ls`
do
	number=${file:1:2}
	addon=${file:4:1}
	name="细说红楼梦"$number$addon".mp3"
	mv $file $name;
done
#得到文件名
#细说红楼梦64下.mp3
#用 python 批量更改 mp3tags


#!/usr/bin/env python
#coding:utf-8

import os
import re
import sys
import eyed3

if __name__ == "__main__":
    if len(sys.argv)!=2:
        print("please input mp3 directory")
        exit()

    dir=sys.argv[1]
    for filename in os.listdir(dir):
        filepath=os.path.join(dir,filename)
        if(filename.endswith("mp3")):
            print(filename)
            try:
                audiofile=eyed3.load(filepath)
                audiofile.tag.title=u""
                audiofile.tag.artist=u'蒋勋'
                audiofile.tag.album=u'细说红楼梦'
                audiofile.tag.album_artist=u'蒋勋'
                audiofile.tag.comment=u'不惜歌者苦，但伤知音稀'
                audiofile.tag.subtitle=u''
                audiofile.tag.save()
            except:
                pass
            #print("mp3tag edit for %s %s done",filepath,filename)
        
        else:
            print("Error",filepath)
            pass
