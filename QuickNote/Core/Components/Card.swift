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
            Text(getAttributedString(markdown: item.body))
//                .lineLimit(3)
            Text(item.dateFormatted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.random())
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(item: Notes(id: "001", title: "How to grow your online presence", body: "Source: [Link](https://www.lipsum.com/) It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using **Lorem Ipsum** is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).", createdTime: 1662435338, imageURL: "https://cdn.dribbble.com/userupload/3490202/file/original-1b4619bf6bcd2b67ba5fbf056cd64d03.jpg"))
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

extension Card {
    func getAttributedString(markdown: String) -> AttributedString {
        do {
            let attributedString = try AttributedString(markdown: markdown)
            return attributedString
        } catch {
            print("Couldn't parse: \(error)")
        }
        return AttributedString("Error parsing markdown")
    }
    
}
