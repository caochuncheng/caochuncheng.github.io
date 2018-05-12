#!/bin/bash

### PNG无损压缩优化，再有损压缩
### 注: 如果压缩的最终文件大小大于源文件，即使用源文件
### Create Date: 2014-08-11
### Author : caochuncheng2002@gmail.com

### pngcrush 批量使用脚本
###
### 1，安装说明参考
### 	http://www.mactricksandtips.com/2012/02/installing-and-using-pngcrush-on-your-mac.html
### 2，关键步骤
### 	a.下载开源代码 http://sourceforge.net/projects/pmt/files/pngcrush/
### 	b.操作步骤
###			tar xpvf pngcrush-1.7.76.tar.xz -C ~/Downloads/
###    		cd pngcrush-1.7.76
###    		make (执行编译)
###    		sudo mv pngcrush /usr/local/bin/
###    		pngcrush -version (检查安装)
### 		命令实例
###         pngcrush -rem alla -reduce -brute -nofilecheck -blacken -bail -cc srcfile.png outfile.png
###
### 3，使用实例
### 	a.将本脚本 放在 /Users/ccc/sh/pngcrush.sh 
### 	b.在桌面创建目录 PngCrush
### 	c.只需要放需压缩的文件放入 PngCrush目录
### 	d.执行以下脚本即可 sh /Users/ccc/sh/pngcrush.sh /Users/ccc/Desktop/PngCrush
### 4，命令参数参考
###    http://pwet.fr/man/linux/commandes/pngcrush
###
###
### 5，安装 pngquant 下载 http://pngquant.org/ 根据相应的平台下载
### 	注：已经有Binary版本，不需要编译，直接添加到系统bin即可
### 	做一下link 即可 /usr/local/bin/pngquant 确保文件可执行
###     pngquant -h 使用此命令检查安装是否正常
### 	命令实例
###     透明过渡颜色比较多的使用
###     pngquant --force --speed=1 --ordered 256 --output outfile.png  srcfile.png
###     一般情况下使用
###     pngquant --iebug --force --speed=1 --ordered 256 --output outfile.png  srcfile.png


## 检查参数
if [ "$1" = '' ] ; then
    echo '=======================================警告==================================='
    echo " 需要pngcrush的文件目录: /Users/ccc/Downloads/icon"
    echo " 是否覆盖源文件: true or false"
    echo " 是否启用 IE6-friendly alpha: true or false (默认启用)"
    echo " 执行例子: /bin/bash /data/sh/pngcrush.sh PNG目录 isIEBug 是否覆盖"
    echo " /bin/bash /data/sh/pngcrush.sh /Users/ccc/Downloads/icon true false"
    echo " 默认不覆盖"
    echo " 处理图片的路径，不能存在空格等特殊符号"
    echo " sh /Users/ccc/sh/pngcrush.sh /Users/ccc/Desktop/PngCrush"
    echo '=======================================警告===================================\n'
    exit 1
fi

PNG_DIR=$1
IS_IEBUG=true
if [ "$2" != '' ] ; then
    IS_COVER=$2
fi
IS_COVER=false
if [ "$3" != '' ] ; then
    IS_COVER=$3
fi
PNG_CRUSH_DIR=${PNG_DIR}/PngCrush

## 初始化
if [ ! -d ${PNG_CRUSH_DIR} ] ; then
    mkdir ${PNG_CRUSH_DIR}
else
	rm -rf ${PNG_CRUSH_DIR}
	mkdir ${PNG_CRUSH_DIR}
fi

echo "开始执行压缩 ${PNG_DIR} 下所有PNG文件\n\n"

for pngfile in `find $1 -name "*.png"`;
do
	if [ -f ${pngfile} ] ; then
		TargetPNG=${pngfile/${PNG_DIR}/${PNG_CRUSH_DIR}}
		TargetPNG_ROOT=${TargetPNG%\/*.png}
		if [ ! -d ${TargetPNG_ROOT} ]; then
			mkdir ${TargetPNG_ROOT}
		fi
		#有损压缩
		if [ "${IS_IEBUG}" = true ]; then
			pngquant --iebug --speed=1 --force --ordered 256 --output ${TargetPNG}.png  ${pngfile}
		else
			pngquant --force --speed=1 --ordered 256 --output ${TargetPNG}.png  ${pngfile}
		fi
		#无损优化
		pngcrush -rem alla -reduce -brute -nofilecheck -blacken -bail -cc ${TargetPNG}.png ${TargetPNG}
		
		mv -f ${TargetPNG}.png ${TargetPNG}
		#判断文件大小
		SrcFileSize=`ls -l ${pngfile} | awk '{print $5}'`
		TargetFileSize=`ls -l ${TargetPNG} | awk '{print $5}'`

		if [ ${TargetFileSize} -gt ${SrcFileSize} ]; then
			\cp -f ${pngfile} ${TargetPNG}
		fi

		if [ "${IS_COVER}" = true ] ; then
			echo "压缩 ${pngfile}，并覆盖源文件"
			mv -f ${TargetPNG} ${pngfile}
		else
			echo "压缩 ${pngfile}"
			echo "生成压缩文件 ${TargetPNG}"
		fi
	fi
done

if [ "${IS_COVER}" = true ] ; then
	rm -rf ${PNG_CRUSH_DIR}
fi

echo "\n\n${PNG_DIR} 下所有PNG文件压缩完成\n"