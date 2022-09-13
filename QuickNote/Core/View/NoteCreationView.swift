//
//  NoteCreationView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

enum CameraType {
    case camera, photoLibrary
}

struct NoteCreationView: View {
    @Environment(\.dismiss) var dismissMode
    @StateObject var hapticVM = HapticManager()
    
    // confimation dialog
    @State var openActionSheet: Bool = false
    @State var openCameraRole: Bool = false
    @State var cameraType: CameraType = .photoLibrary
    @State var imageSelected: UIImage = UIImage()
    
    @State var title: String = ""
    @State var paragraph: String = ""
    
    var str1 = "**Bold**"
    var str2 = "*Italic*"
    var str3 = "***Bold Italic***"
    var str4 = "~Strike Through~"
    var str5 = "[Click me](https://www.zoho.com)"
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // TODO: custom back button, gallery / camera clips, save button
                    buttonsUI
                    
                    // for checking purpose, for image picker
                    //checkImagePicker
                    
                    titleTextField
                    bodyTextArea
                    notetext
                    
                    Divider().padding(.top)
                    outputTextArea
                }.padding()
                    .onTapGesture {
                        self.endEditing()
                    }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $openCameraRole, onDismiss: loadImage) {
            if cameraType == .camera {
                ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
            } else {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            }
        }
        .confirmationDialog("What do you want to open sir ?", isPresented: $openActionSheet) {
            Button {
                openCameraRole = true
                cameraType = .camera
            } label: {
                Text("Camera")
            }
            Button {
                openCameraRole = true
                cameraType = .photoLibrary
            } label: {
                Text("Photo Gallery")
            }
            Button("Cancel", role: .cancel) {
                openActionSheet = false
            }
        } message: {
            Text("What do you want to open sir?")
        }
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
            ButtonComponent(text: "chevron.left", type: .two, action: {
                hapticVM.impact(style: .soft)
                hapticVM.haptic(type: .success)
                dismissMode()
            })
            Spacer()
            ButtonComponent(text: "paperclip", type: .two, action: {
                hapticVM.impact(style: .soft)
                hapticVM.haptic(type: .success)
                openActionSheet.toggle()
            }).foregroundColor(imageSelected != UIImage() ? .green : .black)
            
            ButtonComponent(text: "Save", action: {
                hapticVM.impact(style: .soft)
                hapticVM.haptic(type: .success)
            })
            .padding(.leading, 8)
            .disabled(title.isEmpty && paragraph.isEmpty)
        }
    }
    
    private var checkImagePicker: some View {
        ZStack {
            if imageSelected == UIImage() {
                Image(systemName: "flame")
            } else {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
            }
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
            Text("\u{2022} \(str5)")
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
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    private func loadImage() {
        guard let _ = imageSelected as UIImage? else { return }
    }
}
