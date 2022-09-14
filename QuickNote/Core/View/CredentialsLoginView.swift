//
//  CredentialsLoginView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import SwiftUI

struct CredentialsLoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismissMode
    @StateObject var hapticVM = HapticManager()
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 40) {
            Title()
            
            userField
            passwordField
            
            authButton
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.blue, Color.purple]
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationBarHidden(true)
        .onTapGesture {
            self.endEditing()
        }
    }
}

struct CredentialsLoginView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsLoginView().environmentObject(AuthenticationManager())
    }
}

extension CredentialsLoginView {
    private var userField: some View {
        TextField("Username", text: $username)
            .foregroundColor(Color(hex: "#000"))
            .accentColor(.black)
            .font(.system(size: 25, weight: .semibold))
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(25)
    }
    
    private var passwordField: some View {
        SecureField("Password", text: $password)
            .foregroundColor(Color(hex: "#000"))
            .accentColor(.black)
            .font(.system(size: 25, weight: .semibold))
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(25)
    }
    
    private var authButton: some View {
        AuthButton(showImage: false, text: "Login")
            .onTapGesture {
                authManager.authenticateWithCredentials(username: username, password: password)
            }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}
