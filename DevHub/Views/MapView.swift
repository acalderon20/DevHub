//
//  MapView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let park = CLLocationCoordinate2D(latitude: 41.882702, longitude: -87.619392)
}

extension MKCoordinateRegion {
    static let chicago = MKCoordinateRegion (
        center: CLLocationCoordinate2D(
            latitude: 41.8781,
            longitude: -87.6298),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
        )
    static let northShore = MKCoordinateRegion(
        center:CLLocationCoordinate2D(
            latitude: 43.4501,
            longitude: -87.2220),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
        )
}

struct MapView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var searchResults: [MKMapItem] = []
    
    

    var body: some View {
        Map(position: $position) {
            Annotation("Milennium Park", coordinate : .park) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "figure.stand")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            ForEach(searchResults, id: \.self) { result in Marker(item:result)
            }
        }
        .onAppear{
            CLLocationManager().requestWhenInUseAuthorization()
        }
        .mapControls{
            MapUserLocationButton()
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom){
        
            HStack{
                Spacer()
                Projects(position: $position, searchResults: $searchResults)
                    .padding(.top)
                Spacer()
                
            }
            .background(.thinMaterial)
            .opacity(0.8)
        }
        .onChange(of: searchResults){
            position = .automatic
        
        
        }
        }
}
   

//@Binding var searchResults : [MKMapItem]
//func search(for query: String) {
//    let request = MKLocalSearch.Request()
////    request.
//
//}
#Preview {
    MapView()
}
