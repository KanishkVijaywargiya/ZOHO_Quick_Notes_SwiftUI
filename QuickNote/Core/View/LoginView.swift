//
//  AuthenticationView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @StateObject var hapticVM = HapticManager()
    
    var body: some View {
        ZStack {
            Color(hex: "#121212").ignoresSafeArea()
            if authManager.showAlert {
                lockScreenView
            }
        }
        .onAppear {
            Task {
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
    private var lockScreenView: some View {
        VStack {
            Image(systemName: "lock.fill")
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            VStack(spacing: 12) {
                Text("QuickNotes Locked")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Text("Unlock with \(LAContext().biometricType.rawValue) to open QuickNotes")
                    .font(.body)
                    .foregroundColor(.white)
            }
            
            Text("Use \(LAContext().biometricType.rawValue)")
                .font(.system(size: 18))
                .foregroundColor(.blue)
                .onTapGesture {
                    hapticVM.impact(style: .soft)
                    hapticVM.haptic(type: .success)
                    Task {
                        await authManager.authenticateWithBiometrics()
                    }
                }
                .padding(.top, 25)
        }
    }
}
