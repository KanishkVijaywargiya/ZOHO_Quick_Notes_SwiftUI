//
//  AuthenticationView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 40) {
            Title()
//            switchCases
        }
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
        .onAppear {
            Task.init {
                await authManager.authenticateWithBiometrics()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationManager())
    }
}

extension LoginView {
    private var switchCases: some View {
        VStack {
            switch authManager.biometryType {
            case .faceID:
                AuthButton(image: "faceid", text: "Login with FaceID")
                    .onTapGesture {
                        Task.init {
                            await authManager.authenticateWithBiometrics()
                        }
                    }
            case .touchID:
                AuthButton(image: "touchid", text: "Login with TouchID")
                    .onTapGesture {
                        Task.init {
                            await authManager.authenticateWithBiometrics()
                        }
                    }
            default:
                NavigationLink(destination: CredentialsLoginView().environmentObject(authManager)
                ) {
                    AuthButton(image: "person.fill", text: "Login with your credentials")
                }
            }
        }
    }
}
