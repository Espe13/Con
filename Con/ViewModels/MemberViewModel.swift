//
//  MemberViewModel.swift
//  Con
//
//  Created by Amanda on 16.02.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class MemberViewModel: ObservableObject {

    private var db = Firestore.firestore()

    @Published var sortedRanks: [String] = [] // Assuming you want to sort and display ranks
    @Published var membersByRanking: [String: [Member]] = [:] // Groups members by their ranking

    func fetchData() {
        db.collection("loc").getDocuments { [weak self] querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            print("Fetched \(documents.count) documents") // Log the count of fetched documents
            
            var members = [Member]()
            let group = DispatchGroup()
            
            documents.forEach { document in
                let data = document.data()
                let role = data["role"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let crsid = data["crsid"] as? String ?? ""
                let ranking = data["ranking"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                
                group.enter() // Indicate the start of an asynchronous task
                let storageRef = Storage.storage().reference(withPath: imageURL)
                
                storageRef.downloadURL { (url, error) in
                    defer { group.leave() } // Ensure group.leave() is called even if an error occurs
                    
                    let downloadURL = url?.absoluteString ?? ""
                    let member = Member(id: document.documentID, name: name, role: role, crsid: crsid, imageURL: downloadURL, ranking: ranking)
                    members.append(member)
                }
            }
            
            // Wait for all downloadURL tasks to complete
            group.notify(queue: .main) {
                // Group members by ranking
                let membersByRanking = Dictionary(grouping: members, by: { $0.ranking })
                
                // Sort ranks
                self?.sortedRanks = membersByRanking.keys.sorted()
                
                // Sort members within each rank if needed
                self?.membersByRanking = membersByRanking.mapValues { group in
                    group.sorted { $0.name < $1.name } // Example: sorting by name within each rank
                }
                
                self?.objectWillChange.send()
            }

        }
    }

}


