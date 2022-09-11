//
//  GalleryComponent.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

struct GalleryComponent: View {
    @StateObject var vm: ImageLoaderViewModel
    
    init(detailItems: Notes) {
        _vm = StateObject(wrappedValue: ImageLoaderViewModel(notes: detailItems))
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 80)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image("swiftuilogo")
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}

struct GalleryComponent_Previews: PreviewProvider {
    static var previews: some View {
        GalleryComponent(detailItems: dev.detail)
    }
}
