# KLNetwork

## 实现功能

- [x] 网络环境监控
- [x] post、get、put、delete
- [x] HUD 方式 post、get、put、delete
- [x] 设置全局 header
- [x] 新增上传功能，支持选择多个文件上传
- [x] 新增下载功能

## 近期更新

> 增加下载和上传

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
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.get("url", parameters: nil, success: { (response) in
    // 请求成功回调
}) { (error) in
   // 请求错误回调
}
```

显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.getWithShowHUD("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Post 请求

不显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.post("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.postWithShowHUD("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Put 请求

不显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.put("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.putWithShowHUD("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

### Delete 请求

不显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.delete("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

显示加载

```swift
/*
*   url 请求地址
*   parameters  请求参数
*   success   请求成功回调
*   fail 请求失败回调
*/
KLNetWork.deleteWithShowHUD("url", parameters: nil, success: { (response) in
// 请求成功回调
}) { (error) in
// 请求错误回调
}
```

下载请求

```swift
/*
*   url 下载地址
*   toPath  下载文件存放地址。默认存放在document文件夹下
*   parameters  请求参数
*   progress   bytesRead 已下载大小   totalBytes 文件总大小
*   filePath 下载文件目标地址  status 下载状态
*   status 为 success  filePath 存在    status 为fail  filePath不存在
*/
KLNetWork.downloadWithShowHUD("url", toPath: "filePath", parameters: nil, progress: { (bytesRead, totalBytes) in

}) { (filePath, status) in

}
```

上传请求

```Swift
/*
*   url 上传地址
*   filesArray  上传文件数组
*   parameters  请求参数
*   progress   bytesRead 已上传大小   totalBytes 文件总大小
*   status 上传状态
*/
KLNetWork.uploadWithShowHUD("url", filesArray: filesArray, parameters: nil, progress: { (bytesRead, totalBytes) in

}) { (status) in

}
```


### 设置全局 Header

```swift
KLNetwork.setGlobalHeaders(["key": "value"])
```
