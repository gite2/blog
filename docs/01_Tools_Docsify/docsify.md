# docsify

> 一个神奇的文档网站生成器

## 一、概述

### 1、介绍

docsify 可以快速生成文档网站，且不会生成静态的 `.html` 文件，所有转换工作都是在运行时。不同于 GitBook、Hexo 会提前生成静态`.html`文件。如何快速上手，只需创建一个 `index.html` 就可以开始编写文档并直接部署。

官网：https://docsify.js.org/#/zh-cn/

### 2、特性

- 无需构建，写完文档直接发布
- 容易使用并且轻量 (压缩后 ~21kB)
- 智能的全文搜索
- 提供多套主题
- 丰富的 API
- 支持 Emoji
- 兼容 IE11
- 支持服务端渲染 SSR

## 二、快速开始

### 1、准备node环境

node环境不多说，是前提，不会的可以请直接进入官网：https://nodejs.org/en/

### 2、全局安装 docsify-cli

```bash
npm i docsify-cli -g
```

![image-20220824120905311](https://img.edjoke.com/2022Study/20220824120905.png)

### 3、命令初始化

```bash
docsify init ./docs
```

![image-20220824121002858](https://img.edjoke.com/2022Study/20220824121002.png)

初始化完成后可以看到`./docs`目录下创建了几个文件

- index.html	  入口文件
- README.md   作为主页内容渲染
- .nojekyll          用于阻止 GitHub Pages 忽略掉下划线开头的文件

不喜欢mpm初始化的也可以手动初始化`index.html`

### 4、手动初始化

不喜欢npm命令的可以直接手动创建一个 `index.html` 文件

```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta charset="UTF-8">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/vue.css">
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      //...
    }
  </script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
</body>
</html>
```



### 5、本地预览

```bash
docsify serve docs # 默认访问地址 http://localhost:3000
docsify serve docs -p 88 # -p端口号 访问地址 http://localhost:88
#其中docs目录
```

运行 `docsify serve` 启动一个本地服务器，可以方便地实时预览效果。默认访问地址 [http://localhost:3000](http://localhost:3000/) 。



![image-20220824122725469](https://img.edjoke.com/2022Study/20220824122725.png)

也可以用-p指定端口。

![image-20220824122840412](https://img.edjoke.com/2022Study/20220824122840.png)

### 6、Loading提示

可以直接在`index.html`里加入自定义加载信息

```html
<!-- index.html -->
<div id="app">加载中</div>
```

如果更改了 `index.html`里div的id配置，需要将该元素加上 `data-app` 属性。

```html
  <!-- index.html -->
  <div data-app id="main">加载中</div>

  <script>
    window.$docsify = {
      el: '#main'
    }
  </script>
```

## 三、多页配置

### 1、单页面

默认初始化项目里的`README.md`就是单页面内容，修改它就能更新单页内容，语法是MarkDown，保存后会自动渲染

![image-20220824153642853](https://img.edjoke.com/2022Study/20220824153642.png)

### 2、多页面

如果需要创建多个页面，或者需要多级路由的网站，在 docsify 里也能很容易的实现。例如创建一个 `page1.md` 文件，那么对应的路由就是 `/#/page1`。

假设你的目录结构如下：

```
.
└── docs
    ├── README.md
    ├── page1.md
    └── docsify
        ├── README.md
        └── guide.md
```

那么对应的访问页面将是

```
docs/README.md        => http://domain.com/#/
docs/page1.md         => http://domain.com/#/page1
docs/docsify/README.md  => http://domain.com/#/docsify/
docs/docsify/guide.md   => http://domain.com/#/docsify/guide
```

#### A、定制侧边栏

> 修改index.html配置文件，配置`loadSidebar` 选项

```html
<!-- index.html -->

<script>
  window.$docsify = {
    loadSidebar: true
  }
</script>
```

> 创建 `_sidebar.md` 文件，内容如下

```markdown
<!-- docs/_sidebar.md -->

* [首页](/)
* [docsify教程](docsify/)
* [docsify导航](docsify/guide)
```

需要在 `./docs` 目录创建 `.nojekyll` 命名的空文件，阻止 GitHub Pages 忽略命名是下划线开头的文件。

文件目录如下：

```bash
.
└── docs
    ├── .nojekyll			#空文件 阻止 GitHub Pages 忽略命名是下划线开头的文件
    ├── _sidebar.md			#侧边栏
    ├── index.html			#入口文件
    ├── README.md			#主页渲染
    ├── page1.md			#page1页面
    └── docsify				#docsify文件夹
        ├── README.md		#docsify首页
        └── guide.md		#docsify导航页
```

![image-20220824162739280](https://img.edjoke.com/2022Study/20220824162739.png)

#### B、嵌套侧边栏

你可能想要浏览到一个目录时，只显示这个目录自己的侧边栏，这可以通过在每个文件夹中添加一个 `_sidebar.md` 文件来实现。`_sidebar.md` 的加载逻辑是从每层目录下获取文件，如果当前目录不存在该文件则回退到上一级目录。

例如当前路径为 `/docsify/more-pages` 则从 `/docsify/_sidebar.md` 获取文件，如果不存在则从 `/_sidebar.md` 获取。



也可以配置 `alias` 避免不必要的回退过程。

```html
<script>
  window.$docsify = {
    loadSidebar: true,
    alias: {
      '/.*/_sidebar.md': '/_sidebar.md'
    }
  }
</script>
```

> 每个子目录中 `README.md` 文件来作为路由的默认网页，`_sidebar.md`作为侧边栏

经过我的优化后，`_sidebar.md`如下

```markdown
<!-- docs/_sidebar.md -->

* [首页](/)
* [docsify](docsify/)
```

```markdown
<!-- docs/docsify/_sidebar.md -->

* [返回](/)
* [docsify教程](docsify/)
* [docsify导航](docsify/guide)
```

文件目录：

```bash
.
└── docs
    ├── .nojekyll			
    ├── _sidebar.md			
    ├── index.html			
    ├── README.md			
    └── docsify				
	    ├── _sidebar.md		#嵌套侧边栏
        ├── README.md		
        └── guide.md		
```



![image-20220824164139772](https://img.edjoke.com/2022Study/20220824164139.png)

#### C、页面标题

页面的 `title` 标签是由侧边栏`_sidebar.md`中选中条目的名称所生成的。为了更好的 SEO ，你可以在文件名后面指定页面标题。

```markdown
<!-- docs/docsify/_sidebar.md -->


* [返回](/)
* [docsify教程](docsify/)
* [docsify导航](docsify/guide "docsify最牛指南")
```

> 默认标题为左侧综括后[ ]里的标题，指定标题则在后面括号中("指定标题")

![image-20220824165056754](https://img.edjoke.com/2022Study/20220824165056.png)

![image-20220824165216021](https://img.edjoke.com/2022Study/20220824165216.png)

#### D、目录层级



在`index.html`种配置参数`subMaxLevel`为2

```html
<!-- index.html -->

<script>
  window.$docsify = {
    loadSidebar: true,
    subMaxLevel: 2
  }
</script>
<script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
```



![image-20220824165709167](https://img.edjoke.com/2022Study/20220824165709.png)

也可在`index.html`种配置参数`subMaxLevel`为4，则显示全部4层级别目录

```html
<!-- index.html -->

<script>
  window.$docsify = {
    loadSidebar: true,
    subMaxLevel: 4
  }
</script>
<script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
```

![image-20220824165809199](https://img.edjoke.com/2022Study/20220824165809.png)

#### E、忽略副标题

设置了 `subMaxLevel` 时，默认情况下每个标题都会自动添加到目录中。如果你想忽略特定的标题，可以给它添加 `<!-- {docsify-ignore} -->` 。

```markdown
# 开始

## 二级标题 <!-- {docsify-ignore} -->

该[二级标题]标题不会出现在侧边栏的目录中。
```

忽略特定页面上的所有标题，你可以在页面的第一个标题上使用 `<!-- {docsify-ignore-all} -->` 。

```markdown
# 开始 <!-- {docsify-ignore-all} -->

## 二级标题

该页面所有标题不会出现在侧边栏的目录中。
```

### 3、自定义导航栏

#### A、HTML

> 注意：链接都要以 `#/` 开头。 这里的导航是顶端横向导航栏

```html
<!-- index.html -->

<body>
  <nav>
    <a href="#/">EN</a>
    <a href="#/zh-cn/">中文</a>
  </nav>
  <div id="app"></div>
</body>
```

```html
<!-- index.html -->

<body>
  <nav>
    <a href="#/">首页</a>
    <a href="#/docsify/">docsify</a>
  </nav>
  <div data-app id="main">加载中。。。</div>
  <script>
    window.$docsify = {
	  el:'#main',
	  loadSidebar: true,
	  subMaxLevel: 4
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
```

> 效果图如下

![image-20220824190023075](https://img.edjoke.com/2022Study/20220824190023.png)

#### B、配置文件

> 在`index.html`配置顶部导航栏参数`loadNavbar`

```html
<body>  
  <div id="app"></div>
  <script>
    window.$docsify = {
      loadSidebar: true,
      subMaxLevel: 4,
      loadNavbar: true
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>

```

> 配置的 `loadNavbar`参数默认加载的文件为 `_navbar.md`，内容和侧边栏一样

```markdown
<!-- docs/docsify/_navbar.md -->


* [返回](/)
* [docsify教程](docsify/)
* [docsify导航](docsify/guide "docsify最牛指南")
```

`_navbar.md` 加载逻辑和 `_sidebar.md` 文件一致，从每层目录下获取。例如当前路由为 `/docs/custom-navbar` 那么是从 `/docs/_navbar.md` 获取导航栏。

#### C、导航栏嵌套

>  如果导航内容过多，可以写成嵌套的列表，会被渲染成下拉列表的形式。

```markdown
<!-- docs/docsify/_navbar.md -->

* [返回](/)


* 入门

  * [快速开始](zh-cn/quickstart.md)
  * [多页配置](zh-cn/more-pages.md)
  * [自定义导航栏](zh-cn/custom-navbar.md)
  * [封面](zh-cn/cover.md)


* 配置
  * [配置项](zh-cn/configuration.md)
  * [主题](zh-cn/themes.md)
  * [使用插件](zh-cn/plugins.md)
  * [Markdown 配置](zh-cn/markdown.md)
  * [代码高亮](zh-cn/language-highlight.md)
  
  
  
* 
```

> 效果图如下

![image-20220824192123385](https://img.edjoke.com/2022Study/20220824192123.png)

#### D、导航栏加入emoji表情

> index.html引入emoji包

```html
<!-- index.html -->

<body>  
  <div id="app"></div>
  <script>
    window.$docsify = {
      loadSidebar: true,
      subMaxLevel: 4,
      loadNavbar: true
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/emoji.min.js"></script>
</body>
```

表情可参考网站https://www.emojiall.com/zh-hans

> 导航栏 Markdown 文件中使用旗帜表情：

```markdown
<!-- docs/docsify/_navbar.md -->

* [返回](/)


* 🎟️入门

  * [:us:快速开始](zh-cn/quickstart.md)
  * [:ru:多页配置](zh-cn/more-pages.md)
  * [🎀 自定义导航栏](zh-cn/custom-navbar.md)
  * [🖃 封面](zh-cn/cover.md)


* 🍅 配置
  * [🍇 配置项](zh-cn/configuration.md)
  * [🍈 主题](zh-cn/themes.md)
  * [🍉 使用插件](zh-cn/plugins.md)
  * [🍊 Markdown 配置](zh-cn/markdown.md)
  * [🍋 代码高亮](zh-cn/language-highlight.md)
  
  
  
* 
```

> 效果如下

![image-20220824194420453](https://img.edjoke.com/2022Study/20220824194420.png)

### 4、封面

#### A、基础用法

> 在`index.html`中配置参数 `coverpage`开启封面。

```html
<!-- index.html -->

<body>  
  <div id="app"></div>
  <script>
    window.$docsify = {
      loadSidebar: true,
      subMaxLevel: 4,
      loadNavbar: true,
      coverpage: true
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/emoji.min.js"></script>
</body>
```

> 文档根目录创建 `_coverpage.md` 文件来配置封面，添加logo文件夹_media里面放logo图片icon.png

```markdown
<!-- _coverpage.md -->

![logo](_media/icon.png)

# 陈默的个人网站 <small>1.2.6</small>

> 分享技术，热爱技术

- 迎着阳光，继续努力
- 书山有路勤为径
- 学海无涯苦作舟

[Gitee](https://gitee.com/gite2)
[Blog](https://blog.edjoke.com/)
[Get Started](#docsify)
```

> 效果如图

![image-20220825134555102](https://img.edjoke.com/2022Study/20220825134555.png)



#### B、自定义背景

目前的背景是随机生成的渐变色，我们自定义背景色或者背景图。在文档末尾用添加图片的 Markdown 语法设置背景。



```markdown
<!-- _coverpage.md -->

![logo](_media/icon.png)

# 陈默的个人网站 <small>1.2.6</small>

> 分享技术，热爱技术

- 迎着阳光，继续努力
- 书山有路勤为径
- 学海无涯苦作舟

[Gitee](https://gitee.com/gite2)
[Blog](https://blog.edjoke.com/)
[Get Started](#docsify)

<!-- 背景图片 -->

![](_media/bg.png)

<!-- 背景色 -->

![color](#f0f0f0)
```

#### C、封面作为首页

> 通常封面和首页是同时出现的，当然你也可以当封面独立出来通过设置onlyCover 选项。

```html
<!-- index.html -->

<body>  
  <div id="app"></div>
  <script>
    window.$docsify = {
      loadSidebar: true,
      subMaxLevel: 4,
      loadNavbar: true,
      coverpage: true,
      onlyCover: true 
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/emoji.min.js"></script>
</body>
```

#### D、多封面

> 如果你的文档网站是多语言的，或许你需要设置多个封面。

例如你的文档目录结构如下

```bash
.
└── docs
    ├── README.md
    ├── guide.md
    ├── _coverpage.md
    └── zh-cn
        ├── README.md
        └── guide.md
        └── _coverpage.md
```

> 首页单独配置封面位置

```js
<!-- index.html -->

window.$docsify = {
  coverpage: {
    '/': 'cover.md',
    '/zh-cn/': 'cover.md'
  }
};
```



## 四、定制化

### 1、主题

> 目前提供三套主题可供选择，模仿 [Vue](https://vuejs.org/) 和 [buble](https://buble.surge.sh/) 官网订制的主题样式。还有 [@liril-net](https://github.com/liril-net) 贡献的黑色风格的主题。

```html
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/vue.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/buble.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/dark.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/pure.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/dolphin.css">
```

> 例如更换第二个buble样式

```html
<!-- index.html -->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/buble.css">
  
</head>
<body>
  <nav>
    <a href="#/">首页</a>
    <a href="#/docsify/">docsify</a>
  </nav>
  <div data-app id="main">加载中。。。</div>
  <script>
    window.$docsify = {
      name: '',
      repo: '',
	  el:'#main',
	  loadSidebar: true,
	  subMaxLevel: 4,
	  loadNavbar: true,
	  coverpage: true,
      onlyCover: true 
    }
  </script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/emoji.min.js"></script>
</body>
</html>

```

> 效果图如下

![image-20220825140300438](https://img.edjoke.com/2022Study/20220825140300.png)

> 更多主题 [docsify-themeable](https://jhildenbiddle.github.io/docsify-themeable/#/) 一个用于docsify的，简单到令人愉悦的主题系统.

### 2、搜索插件

全文搜索插件会根据当前页面上的超链接获取文档内容，在 `localStorage` 内建立文档索引。默认过期时间为一天，当然我们可以自己指定需要缓存的文件列表或者配置过期时间。

```html
<!-- index.html -->

<script>
  window.$docsify = {
    // 默认值
    search: 'auto', 
    
    // 完整配置参数
    search: {
        maxAge: 86400000,//过期时间,单位毫秒,默认一天
        paths: [], // or 'auto'
        placeholder: '请输入搜索关键字',
        noData: '杳无音讯!',
        depth:4	//搜索标题的最大层级, 1 - 6
    }
  }
</script>

<script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/search.min.js"></script>
```

> 效果如下图

![image-20220825142819296](https://img.edjoke.com/2022Study/20220825142819.png)

### 3、复制到剪贴板插件

在所有的代码块上添加一个简单的`Click to copy`按钮来允许用户从你的文档中轻易地复制代码。由[@jperasmus](https://github.com/jperasmus)提供。

> 只需要在`index.html`中添加js

```js
<!-- index.html -->

<script>
  window.$docsify = {
    copyCode: {
        buttonText : '点击复制',
        errorText  : '错误',
        successText: '复制'
    }
  }
</script>
<script src="//cdn.jsdelivr.net/npm/docsify-copy-code/dist/docsify-copy-code.min.js"></script>
```

> 效果如下图

详情可参考 [README.md](https://github.com/jperasmus/docsify-copy-code/blob/master/README.md) 

![image-20220825143557686](https://img.edjoke.com/2022Study/20220825143557.png)

### 4、分页导航插件

> docsify的分页导航插件，由[@imyelo](https://github.com/imyelo)提供。只需要在`index.html`中添加js

```html
<!-- index.html -->

<script src="//cdn.jsdelivr.net/npm/docsify-pagination/dist/docsify-pagination.min.js"></script>
```

### 5、字数统计

这是一款为docsify提供文字统计的插件. [@827652549](https://github.com/827652549)提供

它提供了统计中文汉字和英文单词的功能，并且排除了一些markdown语法的特殊字符例如*、-等

>在`index.html`添加配置

```html
<!-- index.html -->

<script>
window.$docsify = {
  count:{
    countable:true,
    fontsize:'0.9em',
    color:'rgb(90,90,90)',
    language:'chinese'
  }
}
</script>

<script src="//unpkg.com/docsify-count/dist/countable.js"></script>
```

> 效果如图

![image-20220825144023673](https://img.edjoke.com/2022Study/20220825144023.png)



### 6、更多插件

参考 [awesome-docsify](https://docsify.js.org/#/awesome?id=plugins)

## 五、Github Pages部署

### 1、windows需安装git

windows 安装git，日常可以管理代码，编写博客，上传到github、gitee后配置生成Github Pages、Gitee Pages

### 2、Github 配置 Pages

Gitee Pages配置静态页面需要身份证正反面，请大家自行取舍，建议强制使用https勾选，然后就可以启动。

1. 先在Github创建空仓库

![image-20220825174502686](https://img.edjoke.com/2022Study/20220825174502.png)

2. 根据提示本地初始化，并把文档拷贝进去

```bash
git init ## 初始化一个 git 本地仓库

git add file ## 添加需要 push 的文件或文件夹 

git commit -m "first commit" ## 提交到暂存区

git branch -M main  ## 将本地的分支名改为 main 因为现在 github 的主分支名是 main 而不是master

git branch ## 此命令可查看本地名称

git remote add origin https://github.com/gite2/blog.git ## 关联远程仓库

git push -u origin main ## push 至远程仓库
```

3. 推送上更新

```bash
git add *
git commit -m "commit"
git push
```

4. github pages 部署

   > 点击右上角设置Settings，点击左侧pages

   ![image-20220825175446761](https://img.edjoke.com/2022Study/20220825175446.png)

> 选择发布分支

![image-20220825175653025](https://img.edjoke.com/2022Study/20220825175653.png)

> Github Pages 配置如图所示，点击github-pages 

![image-20220825174014561](https://img.edjoke.com/2022Study/20220825174014.png)

> 点击右侧 View deployment 

![image-20220825174147037](https://img.edjoke.com/2022Study/20220825174147.png)

大家可以直接参观我刚上传的博客 https://gite2.github.io/blog/
