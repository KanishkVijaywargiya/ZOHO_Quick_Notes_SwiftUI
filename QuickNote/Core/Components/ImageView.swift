//
//  ImageView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

struct ImageView: View {
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

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(detailItems: dev.detail)
    }
}
