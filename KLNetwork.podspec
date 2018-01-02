Pod::Spec.new do |s|
  s.name = 'KLNetwork'
  s.version = '1.0.0'
  s.ios.deployment_target = '10.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = '基于Alamofire封装的网络请求框架。'
  s.homepage = 'https://github.com/KYangLei/KLNetwork.git'
  s.authors = { 'KYangLei' => '18683331614@163.com' }
  s.source = { :git => 'https://github.com/KYangLei/KLNetwork.git', :tag => s.version }
  s.description = '带有HUD的网络请求框架，提供get、post、put、delete、download、upload的方法。'
  s.source_files = 'KLNetwork/**/*.swift'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'KLProgressHUD'
  s.dependency 'KLStatusBar'
end