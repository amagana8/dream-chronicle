//
//  Edit View.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/14/21.
//

import SwiftUI

struct EditView: View {
    @Binding var dreamData: Dream.Data
    @State private var isPresented = false
    var body: some View {
        List {
            TextField("Title", text: $dreamData.title)
            ZStack(alignment: .leading) {
                if dreamData.summary.isEmpty {
                    Text("Summary")
                        .opacity(0.3)
                }
                TextEditor(text: $dreamData.summary)
                    .opacity(dreamData.summary.isEmpty ? 0.25 : 1)
            }
            DatePicker("Date", selection: $dreamData.date)
            HStack{
                Text("Lucidity")
                Spacer()
                Slider(value: $dreamData.lucidity, in: 1...5, step: 1.0) {
                    Text("Lucidity")
                }
                Spacer()
                Text("\(Int(dreamData.lucidity))")
            }
            HStack{
                Text("Clarity   ")
                Spacer()
                Slider(value: $dreamData.clarity, in: 1...5, step: 1.0) {
                    Text("Clarity")
                }
                Spacer()
                Text("\(Int(dreamData.clarity))")
            }
            ColorPicker("Color", selection: $dreamData.color)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(dreamData: .constant(Dream.data[0].data))
    }
}
