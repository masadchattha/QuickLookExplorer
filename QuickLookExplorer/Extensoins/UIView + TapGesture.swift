//
//  UIView + TapGesture.swift
//  QuickLookExplorer
//
//  Created by Muhammad Asad Chattha on 19/12/2023.
//

import UIKit

private var tapActionKey: UInt8 = 0

extension UIView {

    /// Adds a tap gesture recognizer to the view and executes the closure when tapped.
    /// - Parameter action: A closure to be executed on tap.
    func onClick(action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
        objc_setAssociatedObject(self, &tapActionKey, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func handleTap() {
        guard let tapAction = objc_getAssociatedObject(self, &tapActionKey) as? () -> Void else { return }
        tapAction()
    }
}
