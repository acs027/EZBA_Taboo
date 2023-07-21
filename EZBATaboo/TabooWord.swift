//
//  TabooWord.swift
//  EZBATaboo
//
//  Created by ali cihan on 30.05.2023.
//

import Foundation

struct TabooWord: Identifiable, Decodable, Encodable {
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
}

