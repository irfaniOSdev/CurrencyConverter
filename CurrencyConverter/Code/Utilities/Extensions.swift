//
//  Extensions.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 30/10/2023.
//

import Foundation
import UIKit

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

extension UIViewController {
    static var _nibName: String {
        return String(describing: Self.self) // defaults to the name of the class implementing this protocol.
    }
}

extension UserDefaults {
    
    func lastCurrencyUpdateTime() -> TimeInterval?{
        return UserDefaults.standard.value(forKey: "lastCurrencyUpdateTimeInterval") as? TimeInterval
    }

    func setLastCurrencyUpdateTime(time: TimeInterval?) {
        UserDefaults.standard.setValue(time, forKey: "lastCurrencyUpdateTimeInterval")
        UserDefaults.standard.synchronize()
    }
}
