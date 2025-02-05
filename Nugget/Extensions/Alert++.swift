//
//  Alert++.swift
//  Cowabunga
//
//  Created by sourcelocation on 30/01/2023.
//

import UIKit

// credit: sourcelocation & TrollTools
var currentUIAlertController: UIAlertController?


fileprivate let errorString = NSLocalizedString("发生错误", comment: "")
fileprivate let okString = NSLocalizedString("OK", comment: "")
fileprivate let helpString = NSLocalizedString("帮助", comment: "")
fileprivate let cancelString = NSLocalizedString("取消", comment: "")

extension UIApplication {
    
    func dismissAlert(animated: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController?.dismiss(animated: animated)
        }
    }
    func alert(title: String = errorString, body: String, animated: Bool = true, withButton: Bool = true) {
        DispatchQueue.main.async {
            var body = body
            
            if title == errorString {
                // append debug info
                let device = UIDevice.current
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                let systemVersion = device.systemVersion
                body += "\n\(device.systemName) \(systemVersion), 版本: \(appVersion) 构建: \(appBuild))"
            }
            
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if withButton { currentUIAlertController?.addAction(.init(title: okString, style: .cancel)) }
            self.present(alert: currentUIAlertController!)
        }
    }
    func helpAlert(title: String = errorString, body: String, link: String, animated: Bool = true, dismissButton: Bool = true) {
        DispatchQueue.main.async {
            var body = body
            
            if title == errorString {
                // append debug info
                let device = UIDevice.current
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                let systemVersion = device.systemVersion
                body += "\n\(device.systemName) \(systemVersion), version \(appVersion) build \(appBuild))"
            }
            
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if dismissButton { currentUIAlertController?.addAction(.init(title: okString, style: .cancel)) }
            currentUIAlertController?.addAction(.init(title: helpString, style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: link)!)
            }))
            self.present(alert: currentUIAlertController!)
        }
    }
    func confirmAlert(title: String = errorString, body: String, confirmTitle: String = okString, onOK: @escaping () -> (), noCancel: Bool) {
        DispatchQueue.main.async {
            currentUIAlertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
            if !noCancel {
                currentUIAlertController?.addAction(.init(title: cancelString, style: .cancel))
            }
            currentUIAlertController?.addAction(.init(title: confirmTitle, style: noCancel ? .cancel : .default, handler: { _ in
                onOK()
            }))
            self.present(alert: currentUIAlertController!)
        }
    }
    func change(title: String = errorString, body: String) {
        DispatchQueue.main.async {
            currentUIAlertController?.title = title
            currentUIAlertController?.message = body
        }
    }
    
    func present(alert: UIAlertController) {
        if var topController = self.windows[0].rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true)
            // topController should now be your topmost view controller
        }
    }
}
