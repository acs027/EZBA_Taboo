//
//  ListView.swift
//  EZBATaboo
//
//  Created by Furkan Eken on 26.07.2023.
//

import SwiftUI

struct ListView: View {
    @State private var customWords = ReadData()
    init() {
        customWords.loadCustom()
    }
    var body: some View {
        List {
            ForEach(customWords.words, id: \.id) { word in
                Text(word.key)
            }
            .onDelete(perform: delete)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        customWords.words.remove(atOffsets: offsets)
        customWords.updateData(customWords.words)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
