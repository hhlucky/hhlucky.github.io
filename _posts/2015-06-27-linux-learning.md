---
layout: post
title: Linux Learning
published: true
tags: linux
---

这是一篇关于linux常用命令的博文，主要记录我在学习中遇到的一些容易忘记的linux命令、用法以及注意点。不过，这里需要说明的是，我并不是一个linux的初学者。那么，为什么会有这篇博客呢？原因自己的linux学习基础不扎实，在有了几年linux系统使用经验后，仍然觉得力不从心。然而linux是一个优秀的且免费自由的操作系统这一点是毋庸置疑的，我当然希望自己能够更熟练、更高效的使用linux。所以，从今天开始，重新启程，从linux基础起，对linux的基础知识和用法作进一步的学习和研究，使基础的知识更扎实，同时捡起自己遗漏的知识点，并一一记录。所谓“学而时习之，不亦说乎”！

而这篇博客，正是最遗漏知识点的记录，相信这也是你容易忽略的但却很重要的linux使用技巧吧！闲话少絮，我们开始吧。

## Terminal的使用

### 常用Terminal使用技巧

* Ctr+P：回到上一个命令
* Ctr+R :快速反向查找命令
* Ctr+A：回到行首
* Ctr+E：回到行尾
* Ctr+D：向后删除一个字符
* Ctr+W：向前删除一个单词
* Ctr+向左：向前移动一个单词
* Ctr+向右：向后移动一个单词
* Ctr+l：清屏
* Ctr+u：删除光标前的所以字符

设置命令行快捷键模式

{% highlight sh linenos %}
$ set -o vi #linux命令行快捷键设置为vi模式
$ set -o emacs # inux命令行快捷键设置为emacs模式（默认模式）
{% endhighlight %}

## 常用命令

### 创建文件命令 `ln`
ln 命令用于创建文件链接，包括软链接和硬链接

{% highlight sh linenos %}
$ ln -s source_file dest_file #创建软链接
$ ln source_file dest_file # 创建硬链接
{% endhighlight %}

软链接和硬链接的异同点如下：

* 文件的软链接类似与windows的快捷方式，对于文件的读写实际操作的是一个文件
* 文件的硬链接是源文件的一个副本，与简单copy不同的是，硬链接的文件和源文件是数据同步的（两个文件inode是一致的，每一个正常的文件都有一个inode）
* 另一个不同点是，硬链接是不可以夸磁盘分区的，而软链接则没有这个限制

### 用户权限命令 `umask`
umask用于查看系统默认的创建文件的权限。umask执行的结果返回一串数字如`0022`，其中第一个0是一个权限特殊位，后面的‘0222’是用户权限位，但这是一个权限掩码值。那么，什么是权限掩码值类似与子网掩码，通过这个值来计算用户权限，计算方法是777减去022（**对应位减，而不是算数减**）得到的值是755，那么对应的系统默认创建文件的权限就是`rwxr-xr-r`。不过，通常的做法不需要这么麻烦来计算，而是用如下命令：

{% highlight sh linenos %}
$ umask -S
u=rwx,g=rwx,o=rx
{% endhighlight %}

命令执行返回结果相当明了

*注意：* linux系统有一条权限规则，那就是缺省创建的文件不能授予x（即执行）权限，所以真正创建的文件的默认权限是`rw-r--r--`
umask还可以用于修改默认创建文件权限，命令执行如下：

{% highlight sh linenos %}
$ umask 022 #这里的数字是用户权限位（也是一个权限掩码值）
{% endhighlight %}

### 命令搜索命令`which`和`whereis`
`which`和`whereis`用于显示系统命令所在的目录，绝对路径；不同的是which可以查找命令相应的别名，而whereis可以查找命令的帮助文档位置

### 文件搜索命令`find`
find查询的基本原则，要节省系统资源开销

{% highlight sh linenos %}
$ find -name file_name #根据文件名查找文件
$ find -name *file_name* #
$ find -name file_name??? #
$ find -size file_size #根据文件大小查找文件，文件的大小的单位是block
$ find -user file_owner #根据文件所有者进行查找
$ find -type d #根据文件类型查找，f：二进制文件；d：目录；l：软链接文件
$ find -inum #根据i节点（inode）查找文件
{% endhighlight %}

> 一般1block=512B；+ 表示大于指定大小，- 表示小于指定大小 

按时间查找比较复杂

- 按天查找 ctime、atime、mtime
- 按分钟查找 cmin、amin、mmin
- c-change 改变，表示文件的属性被修改过，比如所有者、所属组、权限等
- a-access 访问
- m-modify 修改，表示文件内容被修改过
- `-`表示多长时间之内，`+`超过多长时间

{% highlight sh linenos %}
$ find /etc -mmin -120 #在/etc目录下查找120分钟内被内容修改过的文件
{% endhighlight %}

find命令可以用连接符实现多个条件组合查找文件

- `-a` and 表示逻辑与 `-o` or 表示逻辑或
- `-exec` 使用格式为 find -name text.txt -exec [要执行替他命令] {} \;
- `-ok` `-ok`与`-exec`的唯一区别是前者会询问确认

{% highlight sh linenos %}
$ find -name text.txt -exec ls -l {} \;  #查找文件名为text.txt的文件，并列出其详细信息
{% endhighlight %}

### 文件搜索命令`locate`
locate用于搜索系统中的文件，但locate是在系统文件的数据库中查找文件，所以查找文件速度非常快
我们可以手动执行`updatedb`命令更新系统文件数据库，一般是定期更新的。需要注意的是locate只在linux系统中存在，在unix系统中不存在。

### `grep`
在文件里面搜索字符串匹配的行并输出。

### `help`
如果用man查找不到命令帮助信息，有可能该命令是shell内置的命令。这时候就可以用help来查看该命令的帮助。

### 打包解包压缩解压缩文件
`gzip` 是一个压缩文件命令（GNU zip），gzip的两个特点

- 只能压缩文件，不能压缩文件名
- 压缩完文件后，源文件就不存在了

解压缩可以用命令`gunzip`命令或`gzip -d`

`tar` 用于打包文件

".tar.gz"为后缀的文件是用tar打包并用gzip压缩后的文件。代码示例

{% highlight sh linenos %}
$ tar -zcvf file_name.tar.gz dir_name # 将dir_name目录的文件打包压缩为file_name.tar.gz
$ tar -zxvf file_name.tar.gz  # 解压缩文件file_name.tar.gz
{% endhighlight %}

`file` 命令用于判断文件的类型，比如用于判断其是否是压缩打包的文件

zip 是一个windows和linux通用的文件压缩格式，`zip`可以压缩文件和目录，压缩目录是需要加-r参数,如`zip -r file_name.zip /etc`

bz2 是zip的升级版，与zip的不同点是

- bz2压缩比很高
- bz2加`-k`选项可以保留源文件

### 网络命令`ping`

{% highlight sh linenos %}
$ ping -c [ping次数] [ip地址]
$ ping -s [数据包大小] [ip地址]
{% endhighlight %}

## vi/vim使用

### vi的模式说明
![vi的模式说明图](/img/linux_learning_images/vi_img.png)

### 常用的编辑命令有

切换到插入模式命令：

- i  最常用的切换到插入模式命令
- a  也能切换到插入模式，确切地讲是在光标后面增加内容
- I  切换到插入模式，并且插入的内容在光标所在行的行首
- A  切换到插入模式，并且插入的内容在光标所在行的行末
- o  小写字母o，在光标所在行的下面插入一个空行，2o表示插入两个空行
- O  大写字母O，在光标所在行的上面插入一个空行，2O表示插入两个空行
 
清除文本命令（命令模式）：

- cc 改变整行，即将整行内容清掉，同时进入编辑模式
- C  从光标开始直至行末的内容被清掉，同时进入编辑模式
 
替换文本命令（命令模式）：

- r  将光标处的字符替换，然后自动切回命令模式
- R  从光标处开始字符替换，直到按Esc才切回命令模式
- s  替换光标所在处的字符，可以输入任意多个字符，直到按Esc才切回命令模式，前面可以带数字，比如2s，表示替换光标处开始往右的两个字符
- S  替换光标所在的行，可以输入任意多个字符，直到按Esc才切回命令模式
- :%s/[old]/[new]/g       用字符串new替换old，/g表示全局替换，不会询问；而/c表示询问是否执行替换

{% highlight sh linenos %}
:n1,n2s/^/#/g  #从行n1到行n1添加注释符#
:n1,n2s/^#//g  #删除从行n1到行n1的注释符#
:n1,n2s/^\/\//g  #删除从行n1到行n1的注释符\\
{% endhighlight %}
 
删除文本命令（命令模式）：

- x  删除当前光标所在的字符
- nx 删除当前光标开始往右的n个字符
- X  删除当前光标所在处往左一位的字符
- nX 删除当前光标左边n个字符，光标所在处的字符不会被删
- D  同C，但不进入编辑模式
- gG 删除当前行到文件末尾的所以行删除
- d0 删除当前行从行首到光标之间的所有字符，光标所在处的字符不会被删
- dd 删除当前整行
- :nd  删除第n行
- :.d   删除当前行
- :$d  删除最后一行
- :'ad  删除带有标记a的行
- :m,nd 删除第m行到第n行

复制命令（命令模式）：

- y
- Y或yy 复制当前行
- dd 剪切当前行
- [n]dd 剪切当前行以下n行
- p或P 粘贴在当前光标所在行下或行上


命令撤消操作

- u   撤消最后一次修改  
- U   撤消当前行的所有修改
-  .   重复最后一次修改  
-  ,   以相反的方向重复前面的f、F、t或T查找命令 
-  ;   重复前面的f、F、t或T查找命令  
-  "np   取回最后第n次的删除(缓冲区中存有一定次数的删除内容，一般为9)
-  n   重复前面的/或?查找命令  
-  N  以相反方向重复前面的/或?命令

其他命令

- :wq 表示保存退出
- ZZ 表示保存退出
- :! \[系统命令\] 在vi里执行系统命令
- :r ![系统命令] 导入系统命令执行的结果
- :r [文件名] 导入文件名
- :map [快捷键] [要触发的操作] 定义快捷键
- :ab [简写] [实际要输入的内容] 定义一些snep



