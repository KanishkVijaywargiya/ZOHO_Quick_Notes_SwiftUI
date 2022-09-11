//
//  ImageView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

struct ImageView: View {
    //    let imageStr: String
    @StateObject var vm: ImageLoaderViewModel
    init(detailItems: Notes) {
        _vm = StateObject(wrappedValue: ImageLoaderViewModel(notes: detailItems))
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            //            AsyncImage(url: URL(string: imageStr)) { imagePhase in
            //                switch imagePhase {
            //                case .empty:
            //                    VStack {
            //                        ProgressView()
            //                    }
            //                    .frame(maxWidth: .infinity)
            //                    .frame(height: 300)
            //                case .failure:
            //                    Image(systemName: "exclamationmark.triangle")
            //                        .frame(height: 80)
            //                case .success(let image):
            //                    image
            //                        .resizable()
            //                        .scaledToFill()
            //                @unknown default:
            //                    fatalError()
            //                }
            //            }
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if vm.isLoading {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
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
