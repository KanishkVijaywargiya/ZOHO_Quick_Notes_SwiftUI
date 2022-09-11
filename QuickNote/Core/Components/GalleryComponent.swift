//
//  GalleryComponent.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI

struct GalleryComponent: View {
    @StateObject var vm = NotesViewModel()
    let detailItems: Notes
    //    @StateObject var vm: ImageLoaderViewModel
    
    //    init(detailItems: Notes) {
    //        _vm = StateObject(wrappedValue: ImageLoaderViewModel(notes: detailItems))
    //    }
    
    var body: some View {
        VStack {
            if detailItems.imageURL?.count == 0 {
                Image(systemName: "fire")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 80)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.allImages, id: \.self) { image in
                            buildImageView(image)
                        }
                    }
                }
                .onAppear {
                    vm.getAllImages(detailItems)
                }
            }
        }
    }
    
    private func buildImageView(_ url: String) -> some View {
        AsyncImage(url: URL(string: url)) { imagePhase in
            switch imagePhase {
            case .empty:
                ProgressView()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 80)
            case .failure:
                Image(systemName: "exclamationmark.triangle")
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 80)
            @unknown default:
                fatalError()
            }
        }
        .overlay(.black.opacity(0.2))
        .frame(maxHeight: 80)
    }
}

struct GalleryComponent_Previews: PreviewProvider {
    static var previews: some View {
        GalleryComponent(detailItems: dev.detail)
        //        GalleryComponent(detailItems: dev.detail)
    }
}
