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
                search(for: "academic buildings", near: userLocation)
            } label: {
                Label("academic buildings", systemImage: "graduationcap")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "cafes", near: userLocation)
            } label: {
                Label("cafe", systemImage: "cup.and.saucer.fill")
            }
            .buttonStyle(.borderedProminent)
                
            Button {
                position = .region(.uiucCampus)
            } label: {
                Label("Chicago", systemImage: "building.columns")
            }
            .buttonStyle(.borderedProminent)
                
            Button {
                position = .region(.urbanaChampaign)
            } label: {
                Label("Lake Michigan", systemImage: "mappin.and.ellipse")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
        .padding()
    }

    func search(for query: String, near location: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .siebelCenter,
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}


