# KLNetwork

## 实现功能

- [x] 网络环境监控
- [x] post、get、put、delete
- [x] HUD 方式 post、get、put、delete
- [x] 设置全局 header
- [x] 上传功能

## 近期更新

> 优化方法

## 运行环境

* iOS 10.0 +
* Xcode 8 +
* Swift 4.0 +

## 安装

### CocoaPods

你可以使用 [CocoaPods](http://cocoapods.org/) 安装 `KLNetwork`，在你的 `Podfile` 中添加：

```ogdl
platform :ios, '10.0'
use_frameworks!

target 'MyApp' do
pod 'KLNetwork'
end
```

## 快速使用

-> KLNetworkRequestSuccess 中的 **json** 参数为 **SwiftyJSON**；在调用 get、getWithShowHUD、post、postWithShowHUD、put、putWithShowHUD、delete、deleteWithShowHUD 中的参数大多数可以不填写，如果不需要设置此参数则可以删除此参数或者传 **nil**

### 导入 `KLNetwork`

```swift
import KLNetwork
```

### 网络监控

```swift
KLNetworkManager.sharedManager.startNetworkMonitoring()
```

### 设置全局 Header

```swift
var Alamofire_header: [String:String]? {
get {
return [
"value":"key"
]
}
}

```
### 设置全局 Header

```swift
KLNetworkHandler.sharedManager.loadData(Path: "member/getMember", showHud: true, HTTPMethod: .get, nil, .body, Success: { (response:[String:AnyObject]) in
}) { (error) in

}

```

