//
//  DreamData.swift
//  DreamLog
//
//  Created by Alexander Magana on 5/16/21.
//

import SwiftUI

class DreamData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
            
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("dreams.data")
    }
    @Published var dreams: [Dream] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.dreams = Dream.data
                }
                #endif
                return
            }
            guard let Dreams = try? JSONDecoder().decode([Dream].self, from: data) else {
                fatalError("Can't decode saved dream data.")
            }
            DispatchQueue.main.async {
                self?.dreams = Dreams
            }
        }
    }
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let dreams = self?.dreams else {
                fatalError("Self out of scope.")
            }
            guard let data = try? JSONEncoder().encode(dreams) else {
                fatalError("Error encoding data.")
            }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Can't write to file.")
            }
        }
    }
}
