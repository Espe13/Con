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
            .navigationTitle("Local Committee")
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
            HStack {
                VStack(alignment: .leading) {
                    Text(member.name)
                        .font(.headline).multilineTextAlignment(.leading).bold()
                    Text(member.role)
                        .font(.subheadline).multilineTextAlignment(.leading).foregroundStyle(CustomColors.accentRed)
                }
                Spacer()
                AsyncImage(url: URL(string: member.imageURL)) { image in
                    image.resizable().cornerRadius(15)
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 45, maxHeight: 45)
                
            }
            
            if isExpanded {
                HStack {
                    AsyncImage(url: URL(string: member.imageURL)) { image in
                        image.resizable().cornerRadius(15)
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
                    
                    VStack {
                        Text(member.info).font(.body)
                        Link(destination: URL(string: member.mail)!) {
                                    Image(systemName: "envelope.fill")
                                        .font(.title) // Adjust the icon size
                                        .foregroundColor(CustomColors.niceBlue) // Adjust the icon color
                                }
                            .buttonStyle(.bordered)
                            .padding([.trailing, .leading], 40)
                    }
                }
            }
        }.padding(5)
    }
}


struct MembersListView_Previews: PreviewProvider {
    static var previews: some View {
        MembersListView()
    }
}

