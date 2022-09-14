//
//  AuthButton.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 14/09/22.
//

import SwiftUI

struct AuthButton: View {
    var image: String?
    var showImage = true
    var text: String
    
    var body: some View {
        HStack {
            if showImage {
                Image(systemName: image ?? "person.fill")
            }
            Text(text)
        }
        .foregroundColor(.black)
        .padding()
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthButton(image: "faceid", text: "Login with FaceID")
    }
}
