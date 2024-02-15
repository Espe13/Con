//
//  TalkListView.swift
//  Con
//
//  Created by Amanda on 15.02.24.
//

import SwiftUI

struct TalkListView: View {
    @ObservedObject private var viewModel = TalkViewModel()
    @State private var selectedTalkID: String? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sortedDates, id: \.self) { date in
                    Section(header: Text(date.formatted(.dateTime.year().month().day().weekday()))) {
                        ForEach(viewModel.talksByDate[date] ?? [], id: \.id) { talk in
                            VStack(alignment: .leading) {
                                Button(action: {
                                    selectedTalkID = (selectedTalkID == talk.id) ? nil : talk.id
                                }) {
                                    HStack {
                                        Text(talk.name)
                                            .font(.title2).bold().foregroundStyle(CustomColors.niceBlue)
                                        Spacer()
                                        Text("\(talk.start.formatted(.dateTime.hour().minute())) - \(talk.end.formatted(.dateTime.hour().minute()))").foregroundStyle(CustomColors.niceBlue)
                                    }
                                }
                                .background(backgroundForTalk(talk: talk))
                                .cornerRadius(5)
                                
                                if selectedTalkID == talk.id {
                                    VStack {
                                        if talk.imageURL != "" {
                                            
                                            Spacer()
                                            AsyncImage(url: URL(string: talk.imageURL)) { image in
                                                        image.resizable().cornerRadius(15)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(maxWidth: 200, maxHeight: 200)
                                            Spacer()
                                                    
                                        }
                                        Text(talk.abstract)
                                        Spacer()
                                            
    
                                    }.transition(.slide)
                                    
                                }
                                
                                Text(talk.title).font(.caption).foregroundStyle(CustomColors.accentRed).bold()
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .navigationTitle("Program")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }

    private func backgroundForTalk(talk: Talk) -> Color {
        let now = Date()
        if talk.start <= now && talk.end >= now {
            return Color.red.opacity(0.2) // Currently running talk
        } else if talk.end < now {
            return Color.gray.opacity(0.5) // Past talk
        } else {
            return Color.clear // Upcoming or default background
        }
    }
}


struct TalkList_Previews: PreviewProvider {
    static var previews: some View {
        TalkListView()
    }
}
