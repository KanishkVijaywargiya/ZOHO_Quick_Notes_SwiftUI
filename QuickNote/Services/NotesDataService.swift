//
//  NotesDataService.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI
import Combine

class NotesDataService {
    static let instance = NotesDataService() //singleton
    @Published var allNotes: [Notes] = []
    var noteSubsciption: AnyCancellable?
    
    private init() {
        getNotes()
    }
    
    func getNotes() {
        guard let url = URL(string: "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/notes") else { return }
        
        noteSubsciption = NetworkingManager.download(url: url)
            .decode(type: [Notes].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedNotes in
                print("go in...")
                guard let self = self else { return }
                self.allNotes = returnedNotes
                self.noteSubsciption?.cancel()
            })
    }
}
/*
 services folder contains files mostly related to 3rd party
 utilities folder contains files mostly services kind of but related to more of internal stuffs.
 */
