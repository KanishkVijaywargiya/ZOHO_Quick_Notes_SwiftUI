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
    @Published var splitNotes: [[Notes]] = []
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
                self?.waterfallLayout(returnedNotes)
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func waterfallLayout(_ arrNotes: [Notes]) {
        var list1: [Notes] = []
        var list2: [Notes] = []
        
        arrNotes.forEach { note in
            let index = arrNotes.firstIndex {$0.id == note.id}
            
            if let index = index {
                if index % 2 == 0 {
                    list1.append(note)
                } else {
                    list2.append(note)
                }
            }
        }
        splitNotes.append(list1)
        splitNotes.append(list2)
    }
}
