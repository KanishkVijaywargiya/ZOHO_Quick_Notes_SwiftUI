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
    
    var str1 = "**Bold**"
    var str2 = "*Italic*"
    var str3 = "~Strike Through~"
    var str4 = "[Click me](https://www.zoho.com)"
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // TODO: custom back button, gallery / camera clips, save button
                    buttonsUI
                    
                    titleTextField
                    bodyTextArea
                    notetext
                    
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
    private var buttonsUI: some View {
        HStack {
            ButtonComponent(text: "chevron.left", type: .two, action: {})
            Spacer()
            ButtonComponent(text: "paperclip", type: .two, action: {})
            
            ButtonComponent(text: "Save", action: {})
                .padding(.leading, 8)
        }
    }
    
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
    
    private var notetext: some View {
        VStack(alignment: .leading) {
            Text("**Note:** You can use markdowns too.\neg.:")
            Text("\u{2022} \(str1)")
            Text("\u{2022} \(str2)")
            Text("\u{2022} \(str3)")
            Text("\u{2022} \(str4)")
        }
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
