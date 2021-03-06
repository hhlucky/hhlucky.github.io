---
layout: post
title: Linux PAHT Setting
published: true
tags: linux system path
---


## Ubuntu Linux 环境变量PATH设置

### Ubuntu Linux系统环境变量配置文件： 
/etc/profile : 在登录时,操作系统定制用户环境时使用的第一个文件 ,此文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行。 

/etc /environment : 在登录时操作系统使用的第二个文件, 系统在读取你自己的profile前,设置环境文件的环境变量。 

~/.profile :  在登录时用到的第三个文件 是.profile文件,每个用户都可使用该文件输入专用于自己使用的shell信息,当用户登录时,该文件仅仅执行一次!默认情况下,他设置一些环境变量,执行用户的.bashrc文件。

/etc/bashrc : 为每一个运行bash shell的用户执行此文件.当bash shell被打开时,该文件被读取. 

~/.bashrc : 该文件包含专用于你的bash shell的bash信息,当登录时以及每次打开新的shell时,该该文件被读取。 



### PASH环境变量的设置方法： 

#### 方法一：用户主目录下的.profile或.bashrc文件（推荐） 

登录到你的用户（非root），在终端输入： 

{% highlight sh linenos %}
$ sudo gedit ~/.profile(or .bashrc) 
{% endhighlight %}

可以在此文件末尾加入PATH的设置如下： 

{% highlight sh linenos %}
export PATH=”$PATH:your path1:your path2 ...” 
{% endhighlight %}

保存文件，注销再登录，变量生效。 
该方式添加的变量只对当前用户有效。 

#### 方法二：系统目录下的profile文件（谨慎） 

在系统的etc目录下，有一个profile文件，编辑该文件： 

{% highlight sh linenos %}
$ sudo gedit /etc/profile 
{% endhighlight %}

在最后加入PATH的设置如下： 

{% highlight sh linenos %}
export PATH=”$PATH:your path1:your path2 ...” 
{% endhighlight %}

该文件编辑保存后，重启系统，变量生效。 
该方式添加的变量对所有的用户都有效。 

#### 方法三：系统目录下的 environment 文件（谨慎） 

在系统的etc目录下，有一个environment文件，编辑该文件： 

{% highlight sh linenos %}
$ sudo gedit /etc/environment 
{% endhighlight %}

找到以下的 PATH 变量： 
PATH="<......>" 
修改该 PATH 变量，在其中加入自己的path即可，例如： 
PATH="<......>:your path1:your path2 …" 
各个path之间用冒号分割。该文件也是重启生效，影响所有用户。 
注意这里不是添加export PATH=… 。 

#### 方法四：直接在终端下输入 

{% highlight sh linenos %}
$ sudo export PATH="$PATH:your path1:your path2 …" 
{% endhighlight %}

这种方式变量立即生效，但用户注销或系统重启后设置变成无效，适合临时变量的设置。 


> 注 意：方法二和三的修改需要谨慎，尤其是通过root用户修改，如果修改错误，将可能导致一些严重的系统错误。因此笔者推荐使用第一种方法。另外嵌入式 Linux的开发最好不要在root下进行（除非你对Linux已经非常熟悉了！！），以免因为操作不当导致系统严重错误。

下面是一个对environment文件错误修改导致的问题以及解决方法示例： 

问题：因为不小心在 etc/environment里设在环境变量导致无法登录 
提示：不要在 etc/environment里设置 export PATH这样会导致重启后登录不了系统 
解决方法： 
在登录界面 alt +ctrl+f1进入命令模式，如果不是root用户需要键入（root用户就不许这么罗嗦，gedit编辑会不可显示） 
/usr/bin/sudo /usr/bin/vi /etc/environment 
光标移到export PATH** 行，连续按 d两次删除该行； 
输入:wq保存退出； 
然后键入/sbin/reboot重启系统（可能会提示need to boot，此时直接power off）
