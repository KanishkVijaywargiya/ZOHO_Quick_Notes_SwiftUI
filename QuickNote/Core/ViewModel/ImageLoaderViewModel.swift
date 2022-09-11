//
//  ImageLoaderViewModel.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 11/09/22.
//

import SwiftUI
import Combine

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let notes: Notes
    private let imageLoader: ImageLoaderService
    private var cancellables = Set<AnyCancellable>()
    
    init(notes: Notes) {
        self.notes = notes
        self.imageLoader = ImageLoaderService(notesObj: notes)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func addSubscriber() {
        imageLoader.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImg in
                self?.image = returnedImg
            }
            .store(in: &cancellables)
    }
}
