//
//  CardView.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/12/21.
//

import SwiftUI

struct CardView: View {
    let dream: Dream
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(dream.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(formatDate(date: dream.date))", systemImage: "calendar")
                Spacer()
                Label("\(dream.lucidity)", systemImage: "lightbulb").padding(.trailing, 5)
                Label("\(dream.clarity)", systemImage: "eyeglasses").padding(.trailing, 20)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(dream.color.accessibleFontColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var dream = Dream.data[0]
    static var previews: some View {
        CardView(dream: dream)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
