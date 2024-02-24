//
//  Projects.swift
//  DevHub
//
//  Created by Jorge Alvarez on 2/24/24.
//

import SwiftUI
import MapKit

struct Projects: View {
    @Binding var position: MapCameraPosition
    @Binding var searchResults: [MKMapItem]
    var userLocation: CLLocationCoordinate2D // Assuming this is passed in somehow

    var body: some View {
        HStack {
            Button {
                search(for: "boba", near: userLocation)
            } label: {
                Label("boba", systemImage: "waterbottle")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "ramen", near: userLocation)
            } label: {
                Label("ramen", systemImage: "fork.knife")
            }
            .buttonStyle(.borderedProminent)
                
            Button {
                position = .region(.chicago)
            } label: {
                Label("Chicago", systemImage: "building")
            }
            .buttonStyle(.bordered)
                
            Button {
                position = .region(.northShore)
            } label: {
                Label("Lake Michigan", systemImage: "water.waves")
            }
            .buttonStyle(.bordered)
        }
        .labelStyle(.iconOnly)
    }

    func search(for query: String, near location: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}


