//
//  ImageLoaderService.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI
import Combine

class ImageLoaderService {
    @Published var image: UIImage? = nil
    private let notesObj: Notes
    var imageSubsciption: AnyCancellable?
    
    init(notesObj: Notes) {
        self.notesObj = notesObj
        getImage()
    }
    
    func getImage() {
        guard let url = URL(string: notesObj.imageURL ?? "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png") else { return }
        
        imageSubsciption = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImg in
                guard
                    let self = self,
                    let downloadImg = returnedImg else { return }
                self.image = downloadImg
                self.imageSubsciption?.cancel()
            })
        
    }
}
