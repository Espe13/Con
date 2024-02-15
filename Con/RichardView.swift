//
//  Richard.swift
//  Con
//
//  Created by Amanda on 14.02.24.
//


import SwiftUI

struct RichardView: View {
    var body: some View {
        NavigationView {
        
            ScrollView {
                VStack {
                    Image("Richard-3").resizable().aspectRatio(contentMode: .fit).cornerRadius(15).padding()
                    Text("Richard Hills was a pioneering, world-leading millimetre astronomer. As fresh graduate students, he and Michael Janssen built the world’s first millimetre interferometer. His research was characterized by the full range of experimental, observational and theoretical activities as the telescopes became more powerful and the scientific opportunities broadened out. The highlights of his contributions include his key roles as project scientist for the James Clerk Maxwell Telescope in Hawaii, still the world’s largest single dish for submillimetre astronomy, and for the ALMA millimetre/submillimetre array in Chile.")
                        .multilineTextAlignment(.leading)
                        .padding()
                    //Spacer().frame(height: 15)
                    Image("RichardBeach").resizable().aspectRatio(contentMode: .fit).cornerRadius(15).padding([.leading, .bottom, .trailing], 15)
                }.navigationBarTitle("Richard Hills", displayMode: .inline)
                Text("His career spanned the evolution of millimetre astronomy from the ‘Wild West’ of the 1960s to the sophisticated aperture synthesis ALMA array which is revolutionizing our understanding of star and planet formation and the astrophysics of the distant Universe of galaxies.   Source: Royal Society Publishing").multilineTextAlignment(.leading).padding()
                Button(action: {
                            // Attempt to open the URL
                            if let url = URL(string: "https://royalsocietypublishing.org/doi/10.1098/rsbm.2022.0044") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }) {
                            HStack {
                                Image(systemName: "book.fill") // Example icon
                                    .foregroundColor(.blue) // Icon color
                                Text("Read more about Richard Hills")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue) // Text color
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1)) // Transparent background
                            .cornerRadius(10) // Rounded corners, if desired
                            .shadow(radius: 0) // Remove shadow for a flat appearance, or adjust as needed
                        }
                Spacer().frame(height: 30)
            }
        }.navigationTitle("Richard")
    }
}


struct RichardView_Previews: PreviewProvider {
    static var previews: some View {
        RichardView()
    }
}
