//
//  ButtonComponent.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct ButtonComponent: View {
    enum Types {
        case one
        case two
    }
    
    var text: String?
    var type: Types = .one
    var action: () -> ()
    
    var body: some View {
        ZStack {
            if (type == .one) {
                Text(text ?? "")
                    .font(.system(size: 26))
                    .padding(8)
                    .background(
                        BlurView(style: .systemMaterial)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 2)
            } else {
                Image(systemName: text ?? "")
                    .renderingMode(.template)
                    .font(.system(size: 26))
                    .padding(8)
                    .frame(width: 50, height: 50)
                    .background(
                        BlurView(style: .systemMaterial)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 2)
            }
        }
        .onTapGesture { action() }
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var action: () -> () = {}
    
    static var previews: some View {
        ButtonComponent(text: "chevron.left", type: .two, action: action)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
