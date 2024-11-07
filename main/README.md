
## ��������

#### ��װ����

��װubuntuϵͳ���Ƽ�20.04�汾

```
$ sudo apt-get install lcov cmake-curses-gui build-essential wget git python3 python3-pip python3-venv libc6-i386 libsystemd-dev
```



#### ��¡�ֿ�

```
$ git clone https://github.com/tuya/luanode-tuyaopen.git
$ git submodule update --init
```



#### ���û�������

```
$ cd tuyaopen
$ export PATH=$PATH:$PWD
```

�� [tuyaopen](https://github.com/tuya/tuyaopen) ·����ӵ�ϵͳ���������С� [tuyaopen](https://github.com/tuya/tuyaopen)  ͨ��  [tos ](https://github.com/tuya/tuyaopen/blob/master/docs/zh/tos_guide.md) ������б��롢���ԵȲ����� [tos ](https://github.com/tuya/tuyaopen/blob/master/docs/zh/tos_guide.md) �������ݻ������������õ�·������  [tuyaopen](https://github.com/tuya/tuyaopen)  �ֿ⣬��ִ�ж�Ӧ������

 [tos ](https://github.com/tuya/tuyaopen/blob/master/docs/zh/tos_guide.md) �������ϸʹ�÷�������ο� [tos ����](https://github.com/tuya/tuyaopen/blob/master/docs/zh/tos_guide.md)��



#### ��������̼�

ʹ�� [Lua](https://github.com/lua/lua) ������Ҫһ�������̼����û����̼��ṩ�� [tuyaopen](https://github.com/tuya/tuyaopen) ���������Լ�  [Lua](https://github.com/lua/lua) ����������������Ҫ�ڹ����ڲ�������벢��¼��Ŀ����ϡ�

```shell
$ cd mian
$ tos build
```

�������֮��̼�λ�ڴ�Ŀ¼֮�£�ͨ�� [tos ](https://github.com/tuya/tuyaopen/blob/master/docs/zh/tos_guide.md) ���������¼��

```shell
$ cd .build/main/bin/
$ ls
-rwxrwxr-x  1 tuyaos tuyaos 4977400 Nov  5 13:35 main_1.0.0*
```

##### �޸�Ŀ���

�����Ҫ�޸�Ŀ��壬��Ҫ�޸Ĺ���Ŀ¼�� `project_build.ini` �ļ���Ŀǰ֧�ֵ�Ŀ�����`ubuntu`��`t1`��`t2`�� `t3`�� `t5`���޸����֮����Ҫɾ��`.build`Ŀ¼�����±��뼴�ɡ�

```ini
[project:main]
platform = ubuntu
```



#### ��������

�̼���¼���֮�������������ɽ��� [Lua](https://github.com/lua/lua) �����̼�ģʽ����`ubuntu` Ŀ��壬����ͨ��`stdin/stdout` �������������ֱ�ӽ��� [Lua](https://github.com/lua/lua) ָ�������Ŀ����ϣ�����ͨ�����ڹ��ߣ����Ӵ���0�����������ֱ�ӽ��� [Lua](https://github.com/lua/lua) ָ�

```shell
[MEM DBG] heap init-------size:524288 addr:0x7ff04ca7f800---------
[01-01 05:09:26 ty I][main.c:37] lfs init
[01-01 05:09:26 ty I][main.c:20] Create init.lua
[01-01 05:09:26 ty I][main.c:29] File written
Lua 5.3.6  Copyright (C) 1994-2020 Lua.org, PUC-Rio
> print("hello world")
hello world
> 
```



## ��д����

luanode-tuyaopen�ı���ֻ֧�� [Lua](https://github.com/lua/lua) ���ԡ�������һ���򵥵�ʾ����

```lua
-- simple mqtt client
c = mqtt.new() 
c:on("conack", function () print("lua recv connect ack") end)
c:on("disconack", function () print("lua recv dis-connect ack") end)
c:connect({host="broker.emqx.io", port=1883, client_id="tuyaopen-01", user_name="emqx", passwd="public"})
```

����ʾ����ο���Ŀ`/lua_examples/`�ļ����е�ʾ����



## Nodemcu-uploader����

֧��[nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader)���ߣ���������һЩ���Ի��������޸ġ�֧��ͨ����������Ŀ��壬�����������ڿ��������н����ļ��ϴ������ء����ݣ�Ҳ֧��ֱ���ڱ��ء�Ŀ����������ļ���ͬʱ֧�ֶԻ�ȡĿ�������̼���Ϣ����Դ��Ϣ�ȡ�

```shell
$ python3 nodemcu-uploader.py --help
usage: nodemcu-uploader [-h] [--verbose] [--silent] [--version] [--port PORT] [--baud BAUD] [--start_baud START_BAUD] [--timeout TIMEOUT]
                        [--autobaud_time AUTOBAUD_TIME]
                        {backup,upload,exec,download,file,sys,terminal,port} ...
```
