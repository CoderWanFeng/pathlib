# [pathlib](https://gitcode.com/python4office/pathlib)

## 简介

`pathlib`提供一套简洁的,面相对象的api调用来操作文件.


## 创建方式
```
// 从字符串创建
const path = Path('folder/file.txt');

// 从多个部分创建
const path2 = Path('folder', 'file.txt');

// 用join运算符连接
const path3 = Path('folder').join('file.txt');


//使用静态方法创建目录对象的时候,需要先初始化Path类,一般在Ability/onWindowStageCreate中初始化

const context = getContext();
Path.initClass(context);

// 从cache目录创建 data/storage/el2/base/haps/demo/cache
const cache = Path.cache()

// 从temp目录创建 data/storage/el2/base/haps/demo/temp
const temp = Path.temp()

// 从files目录创建 data/storage/el2/base/haps/demo/files
const files = Path.files()
```

## 常用对象和方法:

### 通用方法
`exists() 判断路径对象是否存在`

### 文件夹操作
`subPaths() 获取所有的子路径对象`

### 文件操作
`touch() 创建文件`

`unlink() 删除文件`

`rename() 重命名文件`

### 静态方法
`files() 获取沙箱files目录`

`temp() 获取沙箱temp目录`

`cache() 获取沙箱cache目录`

## pathlib的优势:

1.  面向对象的API,更符合使用习惯

2.  自动处理不同系统的路径差异

3.  提供丰富的路径操作方法

4.  代码更简洁易读

建议:

1.  新项目优先使用pathlib

2.  路径处理统一使用Path对象

3.  注意正确处理异常情况

4.  考虑文件编码问题
