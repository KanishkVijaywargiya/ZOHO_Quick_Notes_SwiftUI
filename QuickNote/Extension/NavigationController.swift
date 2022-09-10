//
//  NavigationController.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import Foundation
import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

/** This extension will going to help in swiping back from detail, notes creation screens to home screen. This will going to override the navigationBarHidden(true) feature. */
