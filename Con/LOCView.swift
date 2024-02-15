//
//  LOC.swift
//  Con
//
//  Created by Amanda on 14.02.24.
//


import SwiftUI

struct Person {
    var name: String
    var role: String
    var crsid: String
}

let people = [
    Person(name: "Amanda Stoffers", role: "IT", crsid: "aas208"),
    Person(name: "Jan the Scholtz", role: "Co-Chair", crsid: "abc111"),
    Person(name: "Charlotte Simmonds", role: "Manager", crsid: "abc111"),
    Person(name: "Roberto Maiolino", role: "IT", crsid: "aas208"),
    Person(name: "Joris Witstock", role: "Co-Chair", crsid: "abc111"),
    Person(name: "Steve Brereton", role: "Admin", crsid: "abc111"),
    Person(name: "Lola Danhaive", role: "IT", crsid: "aas208"),
    Person(name: "Ignas Juodžbalis", role: "IT", crsid: "abc111"),
    Person(name: "Tobias Looser", role: "IT", crsid: "aas208"),
    Person(name: "David Puskas", role: "Designer", crsid: "abc111"),
    Person(name: "Natalia Villanueva", role: "Manager", crsid: "abc111"),
    Person(name: "Alison Wilson", role: "Admin", crsid: "aas208"),
    Person(name: "Amanda Stoffers", role: "IT", crsid: "aas208"),
    Person(name: "Jan the Scholtz", role: "Co-Chair", crsid: "abc111"),
    Person(name: "Charlotte Simmonds", role: "Manager", crsid: "abc111"),
    Person(name: "Roberto Maiolino", role: "IT", crsid: "aas208"),
    Person(name: "Joris Witstock", role: "Co-Chair", crsid: "abc111"),
    Person(name: "Steve Brereton", role: "Admin", crsid: "abc111"),
    Person(name: "Lola Danhaive", role: "IT", crsid: "aas208"),
    Person(name: "Ignas Juodžbalis", role: "IT", crsid: "abc111"),
    Person(name: "Tobias Looser", role: "IT", crsid: "aas208"),
    Person(name: "David Puskas", role: "Designer", crsid: "abc111"),
    Person(name: "Natalia Villanueva", role: "Manager", crsid: "abc111"),
    Person(name: "Alison Wilson", role: "Admin", crsid: "aas208")
]

func roleColor(role: String) -> Color {
    switch role {
    case "IT":
        return .blue
    case "Co-Chair":
        return .red
    case "Admin":
        return .green
    default:
        return .gray // Fallback color
    }
}

struct LOCView: View {
    var body: some View {
        NavigationView { // Wrap the content in a NavigationView
            ScrollView {
                ForEach(people, id: \.name) { person in
                    HStack {
                        Text(person.name)
                            .frame(width: 100, alignment: .leading)
                        Text(person.role)
                            .frame(width: 100, alignment: .leading)
                        Text(person.crsid)
                            .frame(width: 100, alignment: .leading)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 20)
                    .background(roleColor(role: person.role).opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("LOC Members", displayMode: .inline) // Set the navigation bar title
        }
    }
}


struct LocView_Preview: PreviewProvider {
    static var previews: some View {
        LOCView()
    }
}
