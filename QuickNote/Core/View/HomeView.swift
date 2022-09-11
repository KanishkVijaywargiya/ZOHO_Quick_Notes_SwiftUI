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
                cardList
            }
            
            // FAB Button
            fabButton
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: NotesViewModel())
    }
}

extension HomeView {
    private var fabButton: some View {
        VStack {
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
    
    private var cardList: some View {
        ScrollView {
            // TODO: needs to check big cards with image.
            //            LazyVStack(spacing: 12) {
            //                ForEach(splitArray[2]) { item in
            //                    NavigationLink {
            //                        DetailView(detailItems: item)
            //                    } label: {
            //                        Card(item: item)
            //                    }
            //                }
            //            }.padding(.horizontal, 18)
            
            HStack(alignment: .top, spacing: 12) {
                LazyVStack(spacing: 12) {
                    ForEach(splitArray[0]) { item in
                        NavigationLink {
                            DetailView(detailItems: item)
                        } label: {
                            Card(item: item)
                        }
                    }
                }
                LazyVStack(spacing: 12) {
                    ForEach(splitArray[1]) { item in
                        NavigationLink {
                            DetailView(detailItems: item)
                        } label: {
                            Card(item: item)
                        }
                    }
                }
            }.padding(.horizontal, 18)
        }
    }
    
    private var splitArray: [[Notes]] {
        var result: [[Notes]] = []
        
        //        var testArr: [Notes] = []
        var list1: [Notes] = []
        var list2: [Notes] = []
        
        vm.allNotes.forEach { note in
            let index = vm.allNotes.firstIndex {$0.id == note.id }
            if let index = index {
                if index % 2 == 0 {
                    list1.append(note)
                }
                // TODO: Logic for big cards with images
                //                if index % 2 == 0 && note.imageURL == nil {
                //                    list1.append(note)
                //                }
                
                //                else if (index % 2 == 0 && note.imageURL != nil) || (index % 2 != 0 && note.imageURL != nil)  {
                //                    testArr.append(note)
                //                }
                else {
                    list2.append(note)
                }
            }
        }
        result.append(list1)
        result.append(list2)
        //        result.append(testArr)
        return result
    }
}
