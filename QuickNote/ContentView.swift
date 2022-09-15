//
//  ContentView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var splashView: Bool = true
     
    var body: some View {
        VStack {
            if splashView {
                SplashScreen()
            } else {
                NavigationView {
                    AuthenticationView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut) {
                    self.splashView = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
