//
//  AddWorkView.swift
//  Assignment Notebook
//
//  Created by Devan Myers on 5/21/25.
//

import SwiftUI

struct AddWorkView: View {
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "Science", "English", "History", "Language", "Arts", "Other"]
    @ObservedObject var workList: WorkList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Course:", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description:", text: $description)
                DatePicker("Due Date:", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Add to list") {
                if course.count > 0 && description.count > 0 {
                    let item = WorkItem(course: course, description: description, dueDate: dueDate)
                    workList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

#Preview {
    AddWorkView(workList: WorkList())
}
