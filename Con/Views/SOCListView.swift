//
//  SOCListView.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//


import SwiftUI
import Combine

struct SOCListView: View {
    @ObservedObject var viewModel = SOCMemberViewModel()
    @State private var expandedMemberID: String? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sortedRanks, id: \.self) { rank in
                    if let members = viewModel.membersByRanking[rank] {
                        Section() {
                            ForEach(members) { member in
                                SOCMemberView(member: member, isExpanded: self.expandedMemberID == member.id)
                                    .onTapGesture {
                                        self.expandedMemberID = (self.expandedMemberID == member.id) ? nil : member.id
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Scientific Committee")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}


struct SOCMemberView: View {
    var member: SOCMember
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
                
                VStack(alignment: .leading) {
                    HStack {
                        AsyncImage(url: URL(string: member.imageURL)) { image in
                            image.resizable().cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                        
                        Link(destination: URL(string: "mailto:" + member.mail)!) {
                                    Image(systemName: "envelope.fill")
                                        .font(.title) // Adjust the icon size
                                        .foregroundColor(CustomColors.niceBlue) // Adjust the icon color
                                }
                            .buttonStyle(.bordered)
                            .padding([.trailing, .leading], 40)
                        
                    }
                    Text(member.info).font(.footnote)
                    if member.link != "" {
                        HStack {
                            Text("Find more information about \(member.name):")
                                .font(.footnote)
                            
                            Link(destination: URL(string: member.link)!){Image(systemName: "link")
                                    .font(.body) // Adjust the icon size
                                    .foregroundColor(CustomColors.niceBlue)
                                    .buttonStyle(.bordered)
                                // Adjust the icon color
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)}
                }
            }
        }.padding(5)
    }
}



struct SOCListView_Previews: PreviewProvider {
    static var previews: some View {
        SOCListView()
    }
}

