//
//  ContentView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView().navigationTitle("Notes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
