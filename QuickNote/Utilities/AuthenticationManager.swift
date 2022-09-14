//
//  AuthenticationManager.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    // this variable can only be set within this class
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert: Bool = false
    
    init() {
        getBiometryType()
    }
    
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Log into your account"
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("isAuthenticated--->", self.isAuthenticated)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                    print("errrooor---->", error)
                }
            }
        }
    }
    
    // this is just a dummy authentication credentials func.
    /// NOTE: once backend such as Firebase / AWS implemented, we can use email logins, apple logins, etc.
    func authenticateWithCredentials(username: String, password: String) {
        if username.lowercased() == "kanishk" && password == "test@123" {
            isAuthenticated = true
        } else {
            errorDescription = "Wrong Credentials"
            showAlert = true
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}


/***
 You have to use .deviceOwnerAuthentication instead of asking for biometrics. If FaceID is available, it will force the attempt to use this either way.
 If you try enough times then you will get another dialogue to "Cancel" or fallback to "Use passcode". Choosing the fallback will show you the passcode screen.
 However, if you specified .deviceOwnerAuthenticationWithBiometrics, you will get the same fallback option. Rather than getting this dialogue I would have expected to receive an error of LAError.Code.biometryLockout. But instead I get this fallback option dialogue. But that is ok...
 However, if I then tap the fallback option to "Use passcode", it will NOT present the passcode alert. Instead it fails with a LAError.Code.userFallback error.
 If you use the policy without biometrics, you will not get and be able to catch the .userFallback error.
 So to sum things up:
 1. If you ask for the deviceOwnerAuthenticationWithBiometrics policy then you will have to handle the fallback yourself.
 2. If you ask for deviceOwnerAuthentication only, then biometrics will be used if available and authorized, otherwise it will automatically fall back to passcode if biometrics is unavailable, or give you the fallback option to enter passcode automatically if biometrics attemps fail.
 ***/
