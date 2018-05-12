#!/bin/bash

### 根据1024x1024大小的icon图片，生成ios app icon
### 支持最新的iphone6 和iphone plus icon
### Create Date: 2014-09-23
### Author : caochuncheng2002@gmail.com

### 1，安装ImageMagick
### 	脚本需要安装ImageMagick才能使用，安装详见官网http://www.imagemagick.org/
### 2，mac xos 建议使用brew进行安装
###		[~]$ brew install ImageMagick
### 3，通过传的icon图片，并在此图片的当前目录下生成icon文件夹存放各种规格的icon和Contents.json
###


## 检查参数
if [ "$1" = '' ] ; then
    echo '=======================================警告==================================='
    echo " 需要icon的文件: /Users/ccc/Downloads/icon/xxx.png"
    echo " /bin/bash /data/sh/genicon.sh /Users/ccc/Downloads/icon/xxx.png"
    echo " icon图片的路径，不能存在空格等特殊符号"
    echo " sh /data/sh/genicon.sh /Users/ccc/Downloads/icon/xxx.png"
    echo '=======================================警告===================================\n'
    exit 1
fi

ICON_FILE=$1
ICON_DIR=${ICON_FILE%\/*.png}
OUTPUT_DIR=${ICON_DIR}/icon

## 初始化
if [ ! -d ${OUTPUT_DIR} ] ; then
    mkdir ${OUTPUT_DIR}
else
	rm -rf ${OUTPUT_DIR}
	mkdir ${OUTPUT_DIR}
fi

convert -resize 72x72   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-72.png"
convert -resize 144x144 "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-72@2x.png"
convert -resize 76x76   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-76.png"
convert -resize 152x152 "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-76@2x.png"
convert -resize 50x50   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Small-50.png"
convert -resize 100x100 "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Small-50@2x.png"
convert -resize 29x29   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Small.png"
convert -resize 58x58   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Small@2x.png"
convert -resize 40x40   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Spotlight-40.png"
convert -resize 80x80   "${ICON_FILE}"  "${OUTPUT_DIR}/ipad-Icon-Spotlight-40@2x.png"
convert -resize 57x57   "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-57.png"
convert -resize 114x114 "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-57@2x.png"
convert -resize 120x120 "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-60@2x.png"
convert -resize 180x180 "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-60@3x.png"
convert -resize 29x29   "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-Small.png"
convert -resize 58x58   "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-Small@2x.png"
convert -resize 87x87   "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-Small@3x.png"
convert -resize 80x80   "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-Spotlight-40@2x.png"
convert -resize 120x120 "${ICON_FILE}"  "${OUTPUT_DIR}/iphone-Icon-Spotlight-40@3x.png"
	
echo "生成ipad or iphone icon，目录为${OUTPUT_DIR}\n"

CONTENTS_JSON_FILE=${OUTPUT_DIR}/Contents.json
CONTENTS_JSON_STR='
{
\n\t"images" : [
\n\t\t{
\n\t\t\t"size" : "29x29",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-Small.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "29x29",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-Small@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"size" : "29x29",
\n\t\t\t"filename" : "iphone-Icon-Small@3x.png",
\n\t\t\t"scale" : "3x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "40x40",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-Spotlight-40@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"size" : "40x40",
\n\t\t\t"filename" : "iphone-Icon-Spotlight-40@3x.png",
\n\t\t\t"scale" : "3x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "57x57",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-57.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "57x57",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-57@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "60x60",
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"filename" : "iphone-Icon-60@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"idiom" : "iphone",
\n\t\t\t"size" : "60x60",
\n\t\t\t"filename" : "iphone-Icon-60@3x.png",
\n\t\t\t"scale" : "3x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "29x29",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Small.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "29x29",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Small@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "40x40",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Spotlight-40.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "40x40",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Spotlight-40@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "50x50",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Small-50.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "50x50",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-Small-50@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "72x72",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-72.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "72x72",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-72@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "76x76",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-76.png",
\n\t\t\t"scale" : "1x"
\n\t\t},
\n\t\t{
\n\t\t\t"size" : "76x76",
\n\t\t\t"idiom" : "ipad",
\n\t\t\t"filename" : "ipad-Icon-76@2x.png",
\n\t\t\t"scale" : "2x"
\n\t\t}
\n\t],
\n\t"info" : {
\n\t\t"version" : 1,
\n\t\t"author" : "xcode"
\n\t}
\n}'

echo ${CONTENTS_JSON_STR} > ${CONTENTS_JSON_FILE}

echo "生成对应的配置文件Contents.json"




