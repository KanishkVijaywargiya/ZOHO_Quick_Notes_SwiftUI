//
//  Card.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI

struct Card: View {
    var item: Notes
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Text(item.dateFormatted)
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.medium)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.random())
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.3), radius: 6, x: 3, y: 6)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(item: dev.detail)
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)).opacity(Double.random(in: 0.5...0.7))
    }
}
