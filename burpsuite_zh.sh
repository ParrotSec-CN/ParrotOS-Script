#!/bin/bash

/usr/lib/jvm/java-8-openjdk-amd64/bin/java -Dfile.encoding=utf-8 -javaagent:/opt/BurpSuiteCommunity/burpsuite_zh.jar -noverify -Xbootclasspath/p:/opt/BurpSuiteCommunity/burp-loader-helper.jar -Xmx2048m -jar /opt/BurpSuiteCommunity/burpsuite_community.jar
