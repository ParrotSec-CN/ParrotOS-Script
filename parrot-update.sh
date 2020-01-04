#!/bin/bash
set -e
DEBIAN_FRONTEND="noninteractive"
DEBIAN_PRIORITY="critical"
DEBCONF_NOWARNINGS="yes"
export DEBIAN_FRONTEND DEBIAN_PRIORITY DEBCONF_NOWARNINGS

Green_font_prefix="\033[41;37m"
Font_color_suffix="\033[5m"
Clean_color_suffix="\033[0m"
Blue_red_prefix="\033[46;31m"

Info="${Font_color_suffix}${Green_font_prefix}[Info]${Clean_color_suffix}"

function remove_clean()
{
    echo -e "${Info} 清除无用软件包，并清理相关垃圾文件"
    apt -y autoremove
    apt -y clean autoclean
}

function write_source()
{
    echo -e ""
    echo -e "${Info} 执行写入源到parrot.list文件"
    echo -e "# parrot repository\n# this file was automatically generated by parrot-mirror-selector" > /etc/apt/sources.list.d/parrot.list
    echo -e "\ndeb https://deb.parrot.sh/parrot/ rolling main contrib non-free\n#deb-src https://deb.parrot.sh/parrot/ rolling main contrib non-free" >> /etc/apt/sources.list.d/parrot.list
    echo -e "\ndeb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free\n#deb-src https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" >> /etc/apt/sources.list.d/parrot.list
    echo -e ""
    echo -e "${Info} 更新系统"
}

function update()
{
    apt update || echo failed to update index lists
    dpkg --configure -a || echo failed to fix interrupted upgrades
    apt --fix-broken --fix-missing install || echo failed to fix conflicts
    apt -y --allow-downgrades --fix-broken --fix-missing dist-upgrade
}

function proxy_update()
{
    proxychains apt update || echo failed to update index lists
    proxychains dpkg --configure -a || echo failed to fix interrupted upgrades
    proxychains apt --fix-broken --fix-missing install || echo failed to fix conflicts
    proxychains apt -y --allow-downgrades --fix-broken --fix-missing dist-upgrade
}

echo -e ""
echo "1.国内(清华源)"
echo "2.国外(官方源)"

echo -e ""
echo -n "请选择: "
read key

if [ "$key" = "1" ]
then
    echo -e ""
    echo -e "${Info} 当前已选择国内环境(清华源)"
    echo -e ""
    sleep 1
    echo -e "${Info} 执行写入源到parrot.list文件"
    echo -e "# parrot repository\n# this file was automatically generated by parrot-mirror-selector" > /etc/apt/sources.list.d/parrot.list
    echo -e "\ndeb https://mirrors.tuna.tsinghua.edu.cn/parrot/ rolling main contrib non-free\n\ndeb https://mirrors.tuna.tsinghua.edu.cn/parrot/ rolling-security main contrib non-free" >> /etc/apt/sources.list.d/parrot.list
    echo -e ""
    echo -e "${Info} 更新系统"
    (apt -y update --fix-missing && apt -y upgrade && apt -y dist-upgrade)
    remove_clean
elif [ "$key" = "2" ]
then
    echo -e ""
    echo -e "${Info} 当前即将选择官网环境(建议配置Proxychains，这样下载速度快一些)"
    echo -e ""
    echo -n "你选择使用Proxychains么（Y/N）: "
    read warning
    if [ "$warning" = "Y" ]
    then
        sleep 1
        write_source
        proxy_update
        remove_clean
    else
        sleep 1
        write_source
        update
        remove_clean
    fi
fi
