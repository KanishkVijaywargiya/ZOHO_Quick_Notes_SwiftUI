//
//  NotesViewModel.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI
import Combine

class NotesViewModel: ObservableObject {
    @Published var allNotes: [Notes] = []
    @Published var allImages: [String] = []
    @Published var isLoading: Bool = false
    
    private var notesDataService = NotesDataService.instance
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getNotes()
    }
    
    func getNotes() {
        isLoading = true
        notesDataService.$allNotes
            .sink { [weak self] returnedNotes in
                self?.allNotes = returnedNotes.sorted(by: {$0.dateFormatted > $1.dateFormatted})
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func getAllImages(_ arr: Notes) {
//        let index = allNotes.firstIndex(where: {$0.id == arr.id})
        var newArrData: [String] = []
        if let firstImage = arr.imageURL {
            let newArr = allNotes.filter {$0.id != arr.id && $0.imageURL != "" && $0.imageURL != nil}
            newArr.forEach { item in
                let imgUrl = item.imageURL
                newArrData.append(imgUrl ?? "")
            }
            newArrData.insert(firstImage, at: 0)
        }
        allImages = newArrData
    }
}
