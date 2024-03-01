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
                let ranking = data["ranking"] as? String ?? "99"
                let imageURL = data["imageURL"] as? String ?? ""
                let info = data["info"] as? String ?? ""
                let link = data["link"] as? String ?? ""
                let mail = "mailto:" + crsid + "@cam.ac.uk"
                
                group.enter() // Indicate the start of an asynchronous task
                let storageRef = Storage.storage().reference(withPath: imageURL)
                
                storageRef.downloadURL { (url, error) in
                    defer { group.leave() } // Ensure group.leave() is called even if an error occurs
                    
                    let downloadURL = url?.absoluteString ?? ""
                    let member = Member(id: document.documentID, name: name, role: role, crsid: crsid, imageURL: downloadURL, ranking: ranking, mail: mail, info: info, link: link)
                    members.append(member)
                }
            }
            

            // Wait for all downloadURL tasks to complete
            group.notify(queue: .main) {
                // Group members by ranking
                let membersByRanking = Dictionary(grouping: members, by: { $0.ranking })
                
                // Sort ranks numerically
                self?.sortedRanks = membersByRanking.keys.compactMap(Int.init).sorted().map(String.init)
                
                // Assign grouped members to ranks without additional sorting
                self?.membersByRanking = membersByRanking
                
                // Trigger UI update
                self?.objectWillChange.send()
            }


        }
    }

}


class SOCMemberViewModel: ObservableObject {

    private var db = Firestore.firestore()

    @Published var sortedRanks: [String] = [] // Assuming you want to sort and display ranks
    @Published var membersByRanking: [String: [SOCMember]] = [:] // Groups members by their ranking

    func fetchData() {
        db.collection("soc").getDocuments { [weak self] querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            print("Fetched \(documents.count) documents") // Log the count of fetched documents
            
            var members = [SOCMember]()
            let group = DispatchGroup()
            
            documents.forEach { document in
                let data = document.data()
                let role = data["role"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let ranking = data["ranking"] as? String ?? "99"
                let imageURL = data["imageURL"] as? String ?? ""
                let mail = data["mail"] as? String ?? ""
                let const = data["const"] as? String ?? ""
                let info = data["info"] as? String ?? ""
                let link = data["link"] as? String ?? ""
                
                group.enter() // Indicate the start of an asynchronous task
                let storageRef = Storage.storage().reference(withPath: imageURL)
                
                storageRef.downloadURL { (url, error) in
                    defer { group.leave() } // Ensure group.leave() is called even if an error occurs
                    
                    let downloadURL = url?.absoluteString ?? ""
                    let member = SOCMember(id: document.documentID, name: name, role: role, const: const, imageURL: downloadURL, ranking: ranking, mail: mail, info: info, link: link)
                    members.append(member)
                }
            }
            

            // Wait for all downloadURL tasks to complete
            group.notify(queue: .main) {
                // Group members by ranking
                let membersByRanking = Dictionary(grouping: members, by: { $0.ranking })
                
                // Sort ranks numerically
                self?.sortedRanks = membersByRanking.keys.compactMap(Int.init).sorted().map(String.init)
                
                // Assign grouped members to ranks without additional sorting
                self?.membersByRanking = membersByRanking
                
                // Trigger UI update
                self?.objectWillChange.send()
            }
        }
    }
}


