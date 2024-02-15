//
//  Map.swift
//  Con
//
//  Created by Amanda on 14.02.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.21_286, longitude: 0.092_868),
        span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
    ))


// The error happens here!
    var body: some View {
        ZStack {
            Map(position: $cameraPosition)

            Button(action: {
                        // Attempt to open the URL
                        if let url = URL(string: "https://www.google.com/maps/d/edit?mid=1kiTV-XqosOvEwHqco-oz3xpRzqfiN7I&usp=sharing") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }) {
                        HStack {
                            Image(systemName: "globe") // Example icon
                                .foregroundColor(.blue) // Icon color
                            Text("Or go here to Google Maps")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue) // Text color
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1)) // Transparent background
                        .cornerRadius(10) // Rounded corners, if desired
                        .shadow(radius: 0) // Remove shadow for a flat appearance, or adjust as needed
                    }
        }
    }
}

//struct MapView: View {
 //   var body: some View {
   ///     VStack {
      //      Image(systemName: "globe")
        //        .imageScale(.large)
         //       .foregroundStyle(.tint)
          //  Link("Map with special markers", destination: URL(string: "https://www.google.com/maps/d/edit?mid=1kiTV-XqosOvEwHqco-oz3xpRzqfiN7I&usp=sharing")!).foregroundColor(.blue).padding()
 //       }
  //      .padding()
 //   }
//}


#Preview {
    MapView()
}
