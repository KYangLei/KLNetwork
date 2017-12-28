# KLStatusBarMessage

## 实现功能

- [x] 显示情景消息
- [x] 自定义（情景背景色、字体颜色、字体、自动消失间隔秒）

## 运行环境

* iOS 10.0 +
* Xcode 8 +
* Swift 3.0 +

## 安装

### CocoaPods

你可以使用 [CocoaPods](http://cocoapods.org/) 安装 `KLStatusBar`，在你的 `Podfile` 中添加：

```ogdl
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
pod 'KLStatusBar'
end
```

### 手动安装

* 拖动 `KLStatusBar` 文件夹到您的项目

## 快速使用

### 导入 `KLStatusBar`

```swift
import KLStatusBarNotification
```

### 显示情景 -> 信息

```swift
KLStatusBarNotification.showInfo("Star 一下吧")
```

### 显示情景 -> 成功

```swift
KLStatusBarNotification.showSuccess("操作成功")
```

### 显示情景 -> 错误

```swift
KLStatusBarNotification.showError("出现错误了")
```

## 自定义显示样式

### 设置字体

```swift
KLStatusBarNotification.setFont(_ font: UIFont)
```

### 设置字体颜色

```swift
KLStatusBarNotification.setTextColor(_ color: UIColor)
```

### 设置情景 -> 信息背景颜色

```swift
KLStatusBarNotification.setInfoBackgroundColor(_ color: UIColor)
```

### 设置情景 -> 出错背景颜色

```swift
KLStatusBarNotification.setErrorBackgroundColor(_ color: UIColor)
```

### 设置情景 -> 成功背景颜色

```swift
KLStatusBarNotification.setErrorBackgroundColor(_ color: UIColor)
```

### 设置自动隐藏时间

```swift
KLStatusBarNotification.setAutoDismissDelay(_ delay: Int)
```

