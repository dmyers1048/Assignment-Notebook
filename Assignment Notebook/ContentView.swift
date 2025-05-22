//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Devan Myers on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var workList = WorkList()
    @State private var showingAddItemView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course).font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    workList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    workList.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("Assignment Notes", displayMode: .inline)
            .foregroundStyle(.blue)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    showingAddItemView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddItemView) {
                AddWorkView(workList: workList)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

struct WorkItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
