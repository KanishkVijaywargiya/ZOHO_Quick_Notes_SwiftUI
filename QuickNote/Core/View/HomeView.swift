//
//  HomeView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = NotesViewModel()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // cards
            if vm.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    ForEach(vm.allNotes) { item in
                        VStack {
                            Card(item: item)
                                .background(
                                    NavigationLink("", destination: DetailView(detailItems: item)).opacity(0)
                                )
                        }
                    }
                }
            }
            
            // FAB Button
            if !vm.isLoading {
                NavigationLink { NoteCreationView() } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .semibold))
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
                .background(Circle().fill(Color.black))
                .padding()
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: NotesViewModel())
    }
}
