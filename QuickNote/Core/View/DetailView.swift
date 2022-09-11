//
//  DetailView.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismissMode
    let detailItems: Notes
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                imageSection
                titleSection
                dateSection
                bodySection
            }
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
    private var imageSection: some View {
        Image("img1")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ButtonComponent(text: "chevron.left", type: .two, action: {dismissMode()})
                    .position(x: 40, y: 80)
            )
    }
    
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
}
