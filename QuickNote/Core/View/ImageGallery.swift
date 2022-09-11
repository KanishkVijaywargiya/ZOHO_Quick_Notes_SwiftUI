//
//  ImageView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

struct ImageGallery: View {
    @Environment(\.dismiss) var dismissMode
    @StateObject var hapticVM = HapticManager()
    let selectedModel: Notes
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HStack(alignment: .center) {
                GalleryComponent(detailItems: selectedModel)
            }
            ButtonComponent(text: "xmark", type: .two, action: {
                hapticVM.impact(style: .soft)
                hapticVM.haptic(type: .success)
                dismissMode()
            })
                .padding(.horizontal)
                .position(x: 40, y: 20)
        }
    }
}

struct ImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        ImageGallery(selectedModel: dev.detail)
    }
}
