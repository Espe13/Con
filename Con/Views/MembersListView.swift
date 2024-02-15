//
//  LOCListView.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import SwiftUI
import Combine

struct MembersListView: View {
    @ObservedObject var viewModel = MemberViewModel()
    @State private var expandedMemberID: String? = nil
    
    var body: some View {
        NavigationView {
            List {
            
                ForEach(viewModel.sortedRanks, id: \.self) { rank in
                    if let members = viewModel.membersByRanking[rank] {
                        Section() {
                            ForEach(members) { member in
                                MemberView(member: member, isExpanded: self.expandedMemberID == member.id)
                                    .onTapGesture {
                                        self.expandedMemberID = (self.expandedMemberID == member.id) ? nil : member.id
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Members")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct MemberView: View {
    var member: Member
    var isExpanded: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(member.name)
                .font(.headline)
            Text(member.role)
                .font(.subheadline)
            
            if isExpanded {
                PreloadedImageView(imageURL: member.imageURL)
                Spacer()
                Text(member.crsid)
            }
        }
    }
}


struct MembersListView_Previews: PreviewProvider {
    static var previews: some View {
        MembersListView()
    }
}

