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
}
