//
//  WorkList.swift
//  Assignment Notebook
//
//  Created by Devan Myers on 5/21/25.
//

import Foundation

class WorkList: ObservableObject {
    @Published var items: [WorkItem] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedData, forKey: "data")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            if let decodedData = try? JSONDecoder().decode([WorkItem].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
}
