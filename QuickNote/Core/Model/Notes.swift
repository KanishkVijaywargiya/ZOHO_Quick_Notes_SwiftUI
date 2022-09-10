//
//  Notes.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import Foundation

struct Notes: Identifiable, Codable {
    let id: String
    let title: String
    let body: String
    let createdTime: Int
    let imageURL: String?
    
    // custom coding keys to these model as API keys are different than wat we have defined in a model.
    enum CodingKeys: String, CodingKey {
        case id, title, body
        case imageURL = "image"
        case createdTime = "created_time"
    }
    
    // computed property
    var dateFormatted: String {
        let time = createdTime
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
}

/*
{
        "id": "NID1",
        "archived": false,
        "title": "How to grow your online presence",
        "body": "Source: [Link](https://www.lipsum.com/) It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using **Lorem Ipsum** is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
        "created_time": 1662435338,
        "image": "https://cdn.dribbble.com/userupload/3490202/file/original-1b4619bf6bcd2b67ba5fbf056cd64d03.jpg"
    },
*/
