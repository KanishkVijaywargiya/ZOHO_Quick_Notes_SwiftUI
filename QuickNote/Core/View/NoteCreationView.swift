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
            ScrollView {
                VStack {
                    // TODO: custom back button, gallery / camera clips, save button
                    // TODO: Note, you can even use markdowns & give some eg. also.
                    titleTextField
                    bodyTextArea
                    Divider().padding(.top)
                    outputTextArea
                }.padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
    }
}

extension NoteCreationView {
    private var titleTextField: some View {
        TextField("Title", text: $title)
            .foregroundColor(Color(hex: "#000"))
            .accentColor(.black)
            .font(.system(size: 45, weight: .semibold))
            .padding(.horizontal, 16)
            .frame(height: 100)
            .background(Color(uiColor: .secondarySystemBackground))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 3, y: 3)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .padding(.vertical, 20)
    }
    
    private var bodyTextArea: some View {
        TextArea(text: $paragraph, placeholder: "Type Something...")
            .padding(.horizontal, 16)
            .foregroundColor(.black)
            .frame(height: 400)
            .background(Color(uiColor: .secondarySystemBackground))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 3, y: 3)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
    
    private var outputTextArea: some View {
        VStack {
            if paragraph.isEmpty {
                EmptyView()
            } else {
                VStack(alignment: .leading) {
                    Text("Output").fontWeight(.bold).padding(.leading)
                    Text(GetAttributeString.getAttributedString(markdown: paragraph))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(16)
                        .padding(.bottom, 16)
                }
                .font(.title2)
            }
        }
    }
}
