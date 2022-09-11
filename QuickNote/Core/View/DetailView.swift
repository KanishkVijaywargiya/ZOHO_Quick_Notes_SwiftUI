//
//  DetailView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismissMode
    @StateObject var hapticVM = HapticManager()
    @State var openImageModel: Notes? = nil
    let detailItems: Notes
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    ImageView(detailItems: detailItems)
                        .onTapGesture {
                            hapticVM.impact(style: .soft)
                            hapticVM.haptic(type: .success)
                            openImageModel = detailItems
                        }
                    titleSection
                    dateSection
                    bodySection
                }
            }
            backButton
        }
        .fullScreenCover(item: $openImageModel) { item in
            ImageGallery(selectedModel: item)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailItems: dev.detail)
    }
}

extension DetailView {
    private var titleSection: some View {
        Text(detailItems.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
    
    private var dateSection: some View {
        Text(detailItems.dateFormatted)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
    
    private var bodySection: some View {
        Text(GetAttributeString.getAttributedString(markdown: detailItems.body))
            .padding()
    }
    
    private var backButton: some View {
        ButtonComponent(text: "chevron.left", type: .two, action: {
            hapticVM.impact(style: .soft)
            hapticVM.haptic(type: .success)
            dismissMode()
        })
            .padding(.horizontal)
            .padding(.top, 40)
    }
}
