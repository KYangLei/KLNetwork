# KLNetwork

## 实现功能

- [x] 网络环境监控
- [x] post、get、put、delete
- [x] HUD 方式 post、get、put、delete
- [x] 设置全局 header

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
KLNetwork.startNetworkMonitoring()
```

### Get 请求

不显示加载

```swift
KLNetWork.get("url", success: { (response) in
    // 请求成功回调
}) { (error) in
   // 请求错误回调
}
```

显示加载

```swift
KLNetWork.getWithShowHUD("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Post 请求

不显示加载

```swift
KLNetWork.post("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
KLNetWork.postWithShowHUD("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Put 请求

不显示加载

```swift
KLNetWork.put("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
KLNetWork.putWithShowHUD("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Delete 请求

不显示加载

```swift
KLNetWork.delete("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
KLNetWork.deleteWithShowHUD("url", success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### 设置全局 Header

```swift
KLNetwork.setGlobalHeaders(["key": "value"])
```
