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
    
    @StateObject private var locationManager = LocationManager() // Add LocationManager as an observed object

    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        Map(position: $position) {
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
                if let userLocation = locationManager.userLocation {
                    Projects(position: $position, searchResults: $searchResults, userLocation: userLocation)
                } else {
                    // Handle case where userLocation is nil (e.g., display a message or fallback view)
                }
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
