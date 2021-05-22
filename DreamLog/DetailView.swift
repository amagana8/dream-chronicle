//
//  DreamView.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/14/21.
//

import SwiftUI

struct DetailView: View {
    @Binding var dream: Dream
    @State private var data: Dream.Data = Dream.Data()
    @State private var isPresented = false
    var body: some View {
        VStack {
            Text("\(formatDate(date: dream.date))")
            List {
                Text(dream.summary)
                Section {
                    HStack {
                        Label("Lucidity", systemImage: "lightbulb")
                        Spacer()
                        Text("\(dream.lucidity)")
                    }
                    HStack {
                        Label("Clarity", systemImage: "eyeglasses")
                        Spacer()
                        Text("\(dream.clarity)")
                    }
                    HStack {
                        Label("Color", systemImage: "paintpalette")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill").foregroundColor(dream.color)
                    }
                }
            }
            .navigationTitle(dream.title)
            .navigationBarItems(trailing: Button("Edit") {
                isPresented = true
                data = dream.data
            })
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    EditView(dreamData: $data).navigationTitle("Edit Dream").navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            dream.update(from: data)
                        })
                }
            }
        }
    }
}

struct DreamView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(dream: .constant(Dream.data[0]))
        }
    }
}
