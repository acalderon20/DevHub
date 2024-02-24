//
//  Projects.swift
//  DevHub
//
//  Created by Jorge Alvarez on 2/24/24.
//

import SwiftUI
import MapKit

struct Projects: View{
    @Binding var position: MapCameraPosition
    
    @Binding var searchResults: [MKMapItem]
    
    
    
    
    var body: some View{
        HStack{
        Button {
            search(for: "playgrounds")
        } label:{
            Label("Playground", systemImage: "figure.2.and.child.holdinghands")
        }
        .buttonStyle(.borderedProminent)
        
        Button{
            search(for: "beach")
        } label: {
            Label("Beaches",systemImage: "figure.waterpolo")
        }
        .buttonStyle(.borderedProminent)
            
            Button{
                position = .region(.chicago)
            }label: {
                Label("Chicago",systemImage: "building")
            }
            .buttonStyle(.bordered)
            
            Button{
                position = .region(.northShore)
            }label: {
                Label("Lake Michigan",systemImage: "water.waves")
            }
            .buttonStyle(.bordered)
    }
    .labelStyle(.iconOnly)
    }
    
func search(for query:String){
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = query
    request.resultTypes = .pointOfInterest
    request.region = MKCoordinateRegion(
        center: .park,
    span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        
        Task {
            let search  = MKLocalSearch(request:request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        
        }
    }
}

