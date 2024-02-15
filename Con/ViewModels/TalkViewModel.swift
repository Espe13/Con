//
//  TalkViewModel.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class TalkViewModel: ObservableObject {
    @Published var talksByDate = [Date: [Talk]]() // Groups talks by their start date
    @Published var sortedDates = [Date]() // To keep track of the sorted dates for iteration

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("talks").getDocuments { [weak self] querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            print("Fetched \(documents.count) documents") // Log the count of fetched documents
            
            var allTalks = [Talk]()
            let group = DispatchGroup()
            
            documents.forEach { document in
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let abstract = data["abstract"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                
                // Convert Timestamp to Date
                let startTimestamp = data["start"] as? Timestamp
                let endTimestamp = data["end"] as? Timestamp
                let start = startTimestamp?.dateValue() ?? Date()
                let end = endTimestamp?.dateValue() ?? Date()
                
                group.enter() // Indicate the start of an asynchronous task
                let storageRef = Storage.storage().reference(withPath: imageURL)
                
                storageRef.downloadURL { (url, error) in
                    defer { group.leave() } // Ensure group.leave() is called even if an error occurs
                    
                    if let downloadURL = url?.absoluteString {
                        let talk = Talk(id: document.documentID, title: title, name: name, abstract: abstract, start: start, end: end, imageURL: downloadURL)
                        allTalks.append(talk)
                    } else {
                        print("Error or no URL for image: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
            
            // Wait for all downloadURL tasks to complete
            group.notify(queue: .main) {
                // Now proceed with grouping and sorting talks
                let talksByDate = Dictionary(grouping: allTalks, by: { Calendar.current.startOfDay(for: $0.start) })
                self?.sortedDates = talksByDate.keys.sorted()
                self?.talksByDate = talksByDate.mapValues { $0.sorted { $0.start < $1.start } }
                
                // Trigger UI update
                self?.objectWillChange.send()
            }
        }
    }

}


