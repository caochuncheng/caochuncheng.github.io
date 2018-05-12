#!/bin/bash

### 将iOS Simulator模拟器APP应用截图分类归类处理方便应用提交使用
### APP截图分类有5种:iPad、3.5-Inch、4-Inch、4.7-Inch、5.5-Inch
###
### 模拟器截图存放的文件一般在用户的~/Desktop，即桌面目录，需要把这所有截图放到一个目录
### 通过本脚本处理这一目录下的截图，最终会生成以下的目录结构:
### ~/Desktop/ScreenShot/
###                     --3.5-Inch/
###                     --4-Inch/
###                     --4.7-Inch/
###                     --5.5-Inch/
###                     --iPad/
###
### 此脚本处理的功能如下:
### 1.模拟器截图的文件名是带空格的，需要处理
### 2.截图过程中是一起载取的，自动按APP分类存放在对应的目录下
### Create Date: 2015-02-15
### Author : caochuncheng2002@gmail.com


### 1，安装ImageMagick
### 	脚本需要安装ImageMagick才能使用，安装详见官网http://www.imagemagick.org/
### 2，mac xos 建议使用brew进行安装
###		[~]$ brew install ImageMagick
### 3，使用identify命令来获取图片的大小 http://www.imagemagick.org/script/identify.php
###    $identify rose.jpg
###    rose.jpg JPEG 70x46 70x46+0+0 8-bit sRGB 2.36KB 0.000u 0:00.000
###
###
###    $identify rose.jpg | awk '{print $3}'
###    70x46

## 检查参数
if [ "$1" = '' ] ; then
    echo '=======================================警告==================================='
    echo " 需要归类整理的iOS Simulator Screen Shot 目录: /Users/ccc/Desktop/ScreenShot"
    echo " /bin/bash /data/sh/iOSSimulatorScreenShotSort.sh /Users/ccc/Desktop/ScreenShot"
    echo " sh /data/sh/iOSSimulatorScreenShotSort.sh /Users/ccc/Desktop/ScreenShot"
    echo '=======================================警告===================================\n'
    exit 1
fi

PNG_DIR=$1

if [ -d ${PNG_DIR} ]; then
	cd ${PNG_DIR}
	find . -iname "*.png" -print0 | while read -r -d $'\0' pngFile; 
	do
		TargetFile=$(echo "${pngFile}" | sed 's/\.\///g')
		TargetFile=$(echo ${TargetFile} | sed 's/ /_/g')
		TargetFile=$(echo ${TargetFile} | sed 's/iOS_Simulator_Screen_Shot_//g')
		TargetFile=$(echo ${TargetFile} | sed 's/年//g')
		TargetFile=$(echo ${TargetFile} | sed 's/月//g')
		TargetFile=$(echo ${TargetFile} | sed 's/日//g')
		TargetFile=$(echo ${TargetFile} | sed 's/\.//g')
		TargetFile=$(echo ${TargetFile} | sed 's/png/\.png/g')


		pngFile=$(echo "${pngFile}" | sed 's/\.\///g')
		if [[ "${pngFile}" != "${TargetFile}" ]]; then
			mv -f "${pngFile}" "${TargetFile}"
		fi
		PNG_SIZE=`identify ${TargetFile} | awk '{print $3}'`
		OUT_DIR=${PNG_DIR}
		if [[ "${PNG_SIZE}" == "1536x2048" ]]; then
			#iPad
			OUT_DIR=${OUT_DIR}/iPad
		fi
		if [[ "${PNG_SIZE}" == "1242x2208" ]]; then
			#5.5-Inch
			OUT_DIR=${OUT_DIR}/5.5-Inch
		fi
		if [[ "${PNG_SIZE}" == "750x1334" ]]; then
			#4.7-Inch
			OUT_DIR=${OUT_DIR}/4.7-Inch
		fi
		if [[ "${PNG_SIZE}" == "640x1136" ]]; then
			#4-Inch
			OUT_DIR=${OUT_DIR}/4-Inch
		fi
		if [[ "${PNG_SIZE}" == "640x960" ]]; then
			#3.5-Inch
			OUT_DIR=${OUT_DIR}/3.5-Inch
		fi
		if [ ! -d ${OUT_DIR} ] ; then
    		mkdir ${OUT_DIR}
		fi
		OUT_FILE=${OUT_DIR}/${TargetFile}
		mv -f "${PNG_DIR}/${TargetFile}" "${OUT_FILE}"

	done
fi
echo "${PNG_DIR}目录下iOS Simulator Screen Shot整理分类处理完成"

