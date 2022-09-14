//
//  AuthenticationView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var authManager = AuthenticationManager()
    
    var body: some View {
        VStack {
            if authManager.isAuthenticated {
                HomeView().navigationTitle("Notes")
            } else {
                LoginView().environmentObject(authManager)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
