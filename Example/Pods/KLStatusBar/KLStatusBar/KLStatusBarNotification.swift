//
//  KLStatusBarNotification.swift
//  KLStatusBarMessage
//
//  Created by 雷珂阳 on 2017/12/27.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import UIKit

// MARK: - KLStatusBarNotification
public class KLStatusBarNotification: UIWindow {
    /// 全局中间变量
    fileprivate var status: String?
    fileprivate var notificationType: NotificationType?
    
    fileprivate lazy var statusLabel: UILabel = {
        $0.autoresizingMask = [.flexibleWidth]
        $0.textAlignment = .center
        $0.font = Config.font
        $0.textColor = Config.textColor
        return $0
    }(UILabel())
    
    fileprivate lazy var statusView: UIView = {
        $0.autoresizingMask = [.flexibleWidth]
        return $0
    }(UIView())
}

extension KLStatusBarNotification {
    /// 显示
    fileprivate func show(notificationType: NotificationType, status: String? = nil) {
        DispatchQueue.main.async {
            self.notificationType = notificationType
            self.status = status
            self.buildView()
            self.updateView()
            self.autoDismiss(delay: Config.autoDismissDelay)
        }
    }
    private func buildView() {
        self.addSubview(self.statusView)
        self.statusView.addSubview(self.statusLabel)
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = .clear
        self.windowLevel = UIWindowLevelStatusBar
        self.makeKeyAndVisible()
        
        self.statusLabel.text = self.status
    }
    /// 更新视图
    private func updateView() {
        self.frame = CGRect(x: 0, y: 0, width: KLStatusBarNotification.screenWidht, height: KLStatusBarNotification.statusBarHeight)
        self.statusView.frame = CGRect(x: 0, y: -KLStatusBarNotification.statusBarHeight, width: KLStatusBarNotification.screenWidht, height: KLStatusBarNotification.statusBarHeight)
        self.statusLabel.frame = CGRect(x: 15, y: 0, width: KLStatusBarNotification.screenWidht - 30, height: KLStatusBarNotification.statusBarHeight)
        switch self.notificationType! {
        case .info:
            self.statusView.backgroundColor = Config.infoBackgroundColor
        case .error:
            self.statusView.backgroundColor = Config.errorBackgroundColor
        case .success:
            self.statusView.backgroundColor = Config.successBackgroundColor
        }
        self.animationShow()
    }
    /// 动画显示
    private func animationShow() {
        UIView.animate(withDuration: 0.3, animations: {
            self.statusView.frame.origin = CGPoint(x: 0, y: 0)
        })
    }
    /// 动画移除
    private func autoDismiss(delay: Int) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(delay), execute: {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.statusView.frame.origin = CGPoint(x: 0, y: -KLStatusBarNotification.statusBarHeight)
                }, completion: { (finished) in
                    self.statusLabel.removeFromSuperview()
                    self.statusView.removeFromSuperview()
                    self.removeFromSuperview()
                })
            }
        })
    }
}

// MARK: - 类计算属性
extension KLStatusBarNotification {
    fileprivate static var screenWidht: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    fileprivate static var statusBarHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    fileprivate static var shared: KLStatusBarNotification {
        get {
            return KLStatusBarNotification()
        }
    }
}

// MARK: - 类方法
extension KLStatusBarNotification {
    /// 显示情景 -> 信息
    public static func showInfo(_ status: String?) {
        shared.show(notificationType: .info, status: status)
    }
    
    /// 显示情景 -> 成功
    public static func showSuccess(_ status: String?) {
        shared.show(notificationType: .success, status: status)
    }
    
    /// 显示情景 -> 错误
    public static func showError(_ status: String?) {
        shared.show(notificationType: .error, status: status)
    }
    
    /// 设置字体
    public static func setFont(_ font: UIFont) {
        Config.font = font
    }
    
    /// 设置字体颜色
    public static func setTextColor(_ color: UIColor) {
        Config.textColor = color
    }
    
    /// 设置情景 -> 信息背景颜色
    public static func setInfoBackgroundColor(_ color: UIColor) {
        Config.infoBackgroundColor = color
    }
    
    /// 设置情景 -> 出错背景颜色
    public static func setErrorBackgroundColor(_ color: UIColor) {
        Config.errorBackgroundColor = color
    }
    
    /// 设置情景 -> 成功背景颜色
    public static func setsuccessBackgroundColor(_ color: UIColor) {
        Config.successBackgroundColor = color
    }
    
    /// 设置自动隐藏延时秒数
    public static func setAutoDismissDelay(_ autoDismissDelay: Int) {
        Config.autoDismissDelay = autoDismissDelay
    }
}

