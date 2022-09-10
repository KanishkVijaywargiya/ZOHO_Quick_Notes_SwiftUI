//
//  GetAttributeString.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import Foundation
import SwiftUI

class GetAttributeString {
    static func getAttributedString(markdown: String) -> AttributedString {
        do {
            let attributedString = try AttributedString(markdown: markdown)
            return attributedString
        } catch {
            print("Couldn't parse: \(error)")
        }
        return AttributedString("Error parsing markdown")
    }
}
