//
//  DreamLogApp.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/11/21.
//

import SwiftUI

@main
struct DreamLogApp: App {
    @ObservedObject private var data = DreamData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DreamsView(dreams: $data.dreams) {
                    data.save()
                }
            }
            .onAppear() {
                data.load()
            }
        }
    }
}
