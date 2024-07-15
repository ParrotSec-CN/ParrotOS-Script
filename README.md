# ParrotOS-Script

> **目录**

<pre><code>.
ParrotOS-Script
├─ README.md
├─ ParrotSec-cn-invite  (Parrot-cn_QQ群问题2)
├─ core_zh.php  (官网中文语言文件)
├─ powershell-empire  (BC-SECURITY的empire脚本)
└─ parrot-update  (ParrotOS自定义更新升级脚本)
</code></pre>

> **Proxychains**

**解决'libproxychains.so.3' from LD_PRELOAD cannot be preloaded**
*无法加载libproxychains.so.3库*

**正确文件位置**
```
$ whereis libproxychains.so.3

$ /usr/lib/x86_64-linux-gnu/libproxychains.so.3
```

**修改配置文件**
```
`sudo vi /usr/bin/proxychains`

export LD_PRELOAD=libproxychains.so.3
# 改为
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libproxychains.so.3
```

**修改配置文件**
```
sudo vi /usr/lib/proxychains3/proxyresolv

DNS_SERVER=${PROXYRESOLV_DNS:-4.2.2.2}
# 改为 (默认的4.2.2.2dns实在是垃圾)
DNS_SERVER=${PROXYRESOLV_DNS:-8.8.4.4}

export LD_PRELOAD=libproxychains.so.3
# 改为
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libproxychains.so.3
```

**修改proxychains配置文件**

```
sudo vi /etc/proxychains.conf

取消屏蔽dynamic_chain
```

> **Dradis**

**开启dradis服务**
`sudo systemctl start dradis.service`

**默认端口3000，但现在的浏览器都针对ssl做了认证，非安全或者字节数过大的一律屏蔽**
`http://127.0.0.1:3000`

[参考](https://dradisframework.com/support/guides/customization/ssl_lets_encrypt.html)

*虽然dradis和beef-xss默认占用了3000端口，我选择修改beef-xss的默认端口*
`sudo vi /etc/beef-xss/config.yaml`
