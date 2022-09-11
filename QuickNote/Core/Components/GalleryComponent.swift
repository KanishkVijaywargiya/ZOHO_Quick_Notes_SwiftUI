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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.allImages, id: \.self) { image in
                    buildImageView(image)
                }
            }
            .frame(maxHeight: 300)
        }
        .padding()
        .onAppear {
            vm.getAllImages(detailItems)
        }
    }
    
    private func buildImageView(_ url: String) -> some View {
        AsyncImage(url: URL(string: url)) { imagePhase in
            switch imagePhase {
            case .empty:
                Color.gray.opacity(0.3).frame(width: UIScreen.main.bounds.width - 20, height: 300)
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
    }
}

struct GalleryComponent_Previews: PreviewProvider {
    static var previews: some View {
        GalleryComponent(detailItems: dev.detail)
    }
}
