---
title: code quality improve
---
## 坏的代码

* 重复的代码(Duplicated Code)

改善方法

> 1. Extract Method
> 2. Pull Up Method
> 3. Template Mehtod
> 4. Extract Class
> 5. 过滤器
> 6. 面向切面
> 7. 统一的异常处理

* 过长的函数(Long Method)

> 每当感觉需要以注释说明点什么的时候,可以把需要说明的东西写进一个独立的函数,并以其用途命名（Extract Method）

* 过大的类(Large Class)

* 过长的参数列(Long Parameter List)

![代码质量改善](/img/code_quality_improve_images/代码质量改善.png)

* 代码的不整洁

>  空格  换行 一行太长，太多的方法调用

![代码质量改善2](/img/code_quality_improve_images/代码质量改善2.png)
![代码质量改善4](/img/code_quality_improve_images/代码质量改善4.png)

 *对比一下(执行了代码格式化后)*

![代码质量改善3](/img/code_quality_improve_images/代码质量改善3.png)

> 1. 养成良好的编码习惯
> 2. 经常使用代码格式化

## 注意事项

* 多使用临时变量,并给临时变量取一个好的名字 意义明确
* 使用的时候再申明临时变量

![代码质量改善1](/img/code_quality_improve_images/代码质量改善1.png)

> 1. 易读
> 2. 节省内存

* 使用基本数据类型的对象类型
* 分层结构体系

![代码质量改善5](/img/code_quality_improve_images/代码质量改善5.png)

>  1. Controller 层 ：web参数处理
>  2. Service层：业务逻辑
>  3. Dao或Mapper层：数据增删改查

* 类和方法的职责单一
* 多用异常返回非预期的结果,而不是返回值

![代码质量改善6](/img/code_quality_improve_images/代码质量改善6.png)
![代码质量改善7](/img/code_quality_improve_images/代码质量改善7.png)
![代码质量改善8](/img/code_quality_improve_images/代码质量改善8.png)

* 让代码说明一切,而不是注释

![代码质量改善9](/img/code_quality_improve_images/代码质量改善9.png)

## 快捷操作

### 下面是一些idea 快捷键和操作

* Extract Method(Ctl+Alt+M)
* Pull Up Method(Pull Members Up/Down)
* Pull Up Method(SuperClass)
* Introduce Parameter Object(Parameter Object)
* 代码格式化(Ctrl+Alt+L)


## 持续改善
* 养成良好的编码习惯
* 先思考和设计，再着手实现
* 当然也要避免过度设计
* 单元测试，测试先行

> 1. 编写测试代码最有用的时机是在开始编程之前
> 2. 编写测试代码其实就是在问自己：添加这个功能需要做些什么
> 3. 可以使你把注意力集中于接口而不是实现
> 4. 单元测试的诀窍：测试你认为最容易出错的地方

* 不断重构

重构：对软件内部结构的一种调整，目的是在不改变软件可观察行为的前提下，提高其可理解性，降低其修改成本。

重构本来就不应该特别拨出时间来做的事情，重构应该随时随地进行；不应该是为了重构而重构，之所以重构，是因为你想做别的事情，而重构可以帮助你把那些事情做好。
  

以下情况可以考虑重构代码

> 1. 添加新的功能的时候
> 2. 修补错误的时候
> 3. 复审代码的时候
  
一般的重构操作

> 1. 重命名：对类，接口，方法，属性等重命名，以使得更易理解
> 2. 抽取代码：将方法内的一段代码抽取为另一个方法，以使得该段代码可以被其他方法调用，这是重构中很重要很常用的，此举可以极大的精炼代码，减少方法的代码行数
> 3. 封装字段：将类的某个字段转换成属性，可以更加合理的控制字段的访问
> 4. 抽取接口：将类的某些属性，方法抽取组成个接口，该类自动实现该接口
> 5. 提升方法内的局部变量为方法的参数：这主要是在写代码的过程中会使用到
> 6. 删除参数：将方法的一个或多个参数删掉
> 7. 重排参数：将方法的参数顺序重新排列
实际应用中，用的最多的是1、2、3，我们可以在写代码的时候有意识的运用代码重构，这样当我们完成编码时代码的质量也能得到保证。

* 代码review

> 1. 结对代码相互review
> 2. 发现问题，修改问题