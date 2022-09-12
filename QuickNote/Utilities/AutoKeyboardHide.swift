//
//  AutoKeyboardHide.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 12/09/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
