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
        .alert(isPresented: $authManager.showAlert) {
            Alert(title: Text("Error"), message: Text(authManager.errorDescription ?? "Error trying to login with credentials, please try again"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
