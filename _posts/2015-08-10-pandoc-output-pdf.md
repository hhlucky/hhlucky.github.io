---
layout: post
title: 让pandoc输出pdf时支持中文
published: true
tags: pandoc
---

主机环境为：Ubuntu 12.04 LTS。对于RH系列，yum安装包的名称可能会有不同，不过yum联想能力比较强，应该不是问题。

### 安装pandoc，安装tex-live

{% highlight sh linenos %}
apt-get install pandoc texlive texlive-latex-extra texlive-latex-recommanded
{% endhighlight %}

注意，如果要用beamer生成幻灯片的话，则要从cabal安装。

{% highlight sh linenos %}
apt-get install cabal-install
cabal update
cabal install pandoc
echo "export PATH="$HOME/.cabal/bin:$PATH" >> ~/.bashrc
{% endhighlight %}

### 安装中文字体

可以用“fc-list"命令查看已安装字体。使用如下命令安装gnome中文字体。

{% highlight sh linenos %}
apt-get install apt-get install language-pack-gnome-zh*
{% endhighlight %}

如果有ttf文件，比如Windows的字体文件在（Windows\fonts）下，双击即可安装。

### 自定义latex模板

使用下面命令将pandoc标准模板导出：

{% highlight sh linenos %}
pandoc -D latex > template.tex
{% endhighlight %}

在模板中找到"% if luatex or xetex"，在该语句下面插入如下代码：

{% highlight sh linenos %}
% SUPPORT for Chinese
  \usepackage[boldfont,slantfont,CJKsetspaces,CJKchecksingle]{xeCJK}
  \usepackage{fontspec,xltxtra,xunicode}
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}

  \punctstyle{quanjiao}
  \setCJKmainfont{文泉驿微米黑} 
  \setCJKsansfont{KaiTi}
  \setCJKmonofont{SimSun}
{% endhighlight %}

  其中"\setCJKmainfont"设置字体部分，根据系统已安装字体自行修改。

### 配置pandoc命令参数

在.bashrc下添加如下代码

{% highlight sh linenos %}
alias pandoc="pandoc --template=$HOME/Templates/template.tex --latex-engine=xelatex"
{% endhighlight %}

其中，template参数表示pandoc使用的自定义模板路径，我将它放在~/Templates下。

使用xelatex作为latex引擎，它可以直接使用系统已安装的字体，非常方便。