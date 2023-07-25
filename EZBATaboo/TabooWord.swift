//
//  TabooWord.swift
//  EZBATaboo
//
//  Created by ali cihan on 30.05.2023.
//

import Foundation

struct TabooWord: Identifiable, Codable {
    let id = UUID()
    let key: String
    let forbidden_words: [String]
    
    enum CodingKeys: String, CodingKey {
        case key, forbidden_words
    }
}

class ReadData: ObservableObject {
    @Published var words = [TabooWord]()

    
    func loadData(_ readFrom: String) {
        guard let url = Bundle.main.url(forResource: readFrom, withExtension: "json")
            else {
            print("Not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let words = try? JSONDecoder().decode([TabooWord].self, from: data!)
        
        for word in words! {
            self.words.append(word)
            print(word.key)
        }
    }
    
    func loadCustom() {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error getting documents directory URL.")
            return
        }
        
        let fileURL = documentsDirectoryURL.appendingPathComponent("custom").appendingPathExtension("json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([TabooWord].self, from: data)
            
            for word in decodedData {
                self.words.append(word)
                print(word.key)
            }
            
        } catch {
            print("Failed to read data: \(error.localizedDescription)")
        }
    }
    
    func updateData(_ newData: [TabooWord]) {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error getting documents directory URL.")
            return
        }
        let fileURL = documentsDirectoryURL.appendingPathComponent("custom").appendingPathExtension("json")
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(newData)
            try encodedData.write(to: fileURL)
            print("Data saved to custom")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
        
    }

}

