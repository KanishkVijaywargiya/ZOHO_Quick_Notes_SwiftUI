//
//  NoteCreationView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct NoteCreationView: View {
    @State var title: String = ""
    @State var paragraph: String = ""
    
    var body: some View {
        ZStack {
            Color(hex: "#121212").ignoresSafeArea()
            
            VStack {
                // TODO: custom back button, gallery / camera clips, save button
                // TODO: Note, you can even use markdowns & give some eg. also.
                
                
                TextField("Title", text: $title)
                    .foregroundColor(Color(hex: "#000"))
                    .accentColor(.black)
                    .font(.system(size: 45, weight: .semibold))
                    .padding(.horizontal, 16)
                    .frame(height: 100)
                    .background(Color(
                        (#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
                    ))
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 3, y: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))

                TextArea(text: $paragraph, placeholder: "Type Something...")
                    .padding(.horizontal, 16)
                    .foregroundColor(.black)
                    .background(Color(
                        (#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1))
                    ))
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 3, y: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
    }
}
