//
//  ContentView.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/11/21.
//

import SwiftUI

struct DreamsView: View {
    @Binding var dreams: [Dream]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newDreamData = Dream.Data()
    let saveAction: () -> Void
    var body: some View {
        List {
            ForEach(dreams) { dream in
                NavigationLink(destination: DetailView(dream: binding(for: dream))) {
                    CardView(dream: dream)
                }
                .listRowBackground(dream.color)
            }
            .onDelete(perform: deleteRow)
        }
        .navigationTitle("Dreams")
        .navigationBarItems(trailing: Button(action: {
                isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(dreamData: $newDreamData)
                    .navigationTitle("New Dream")
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newDream = Dream(title: newDreamData.title, summary: newDreamData.summary, date: newDreamData.date, lucidity: Int(newDreamData.lucidity), clarity: Int(newDreamData.clarity), color: newDreamData.color)
                        dreams.append(newDream)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
    
    private func binding(for dream: Dream) -> Binding<Dream> {
        guard let dreamIndex = dreams.firstIndex(where: {$0.id == dream.id}) else {
            fatalError("Can't find dream in array")
        }
        return $dreams[dreamIndex]
    }
    
    private func deleteRow(at indexSet: IndexSet) {
        dreams.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DreamsView(dreams: .constant(Dream.data), saveAction: {})
        }
    }
}
