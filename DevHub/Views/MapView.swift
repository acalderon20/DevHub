//
//  MapView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/23/24.
//

import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let projectName: String
    let languages: [String]
    let description: String
}


// Sample locations based on your provided coordinates
let sampleLocations = [
    Location(
        name: "Siebel Center for CS",
        coordinate: .siebelCenter,
        projectName: "AI Research Facility",
        languages: ["Python", "TensorFlow", "Keras"],
        description: "Developing next-gen AI algorithms for healthcare."
    ),
    Location(
        name: "ECE Building",
        coordinate: .eceb,
        projectName: "Hackathon Management System",
        languages: ["JavaScript", "React", "Node.js"],
        description: "A web platform to manage hackathon events seamlessly."
    ),
    Location(
        name: "Grainger Engineering Library",
        coordinate: .graingerLibrary,
        projectName: "Sports Analytics Platform",
        languages: ["R", "Shiny", "Python"],
        description: "Analyzing sports data to enhance team performance metrics."
    ),
    Location(
        name: "Mechanical Engineering Building",
        coordinate: .mechSEBuilding,
        projectName: "Sustainable Energy Tracker",
        languages: ["Swift", "RealityKit", "ARKit"],
        description: "AR app to visualize and track renewable energy sources."
    ),
    Location(
        name: "Digital Computer Lab",
        coordinate: .digitalComputerLab,
        projectName: "Startup Ecosystem Explorer",
        languages: ["Dart", "Flutter", "Firebase"],
        description: "Mapping the startup landscape in Silicon Valley."
    ),
    Location(
        name: "Chemistry Annex",
        coordinate: .chemistryAnnex,
        projectName: "Interactive Art Platform",
        languages: ["JavaScript", "Three.js", "WebGL"],
        description: "Bringing digital art to life through interactive installations."
    ),
    Location(
        name: "Newmark Civil Engineering Lab",
        coordinate: .newmarkCivilEng,
        projectName: "Green Building Design Toolkit",
        languages: ["C#", ".NET", "Blazor"],
        description: "Software for designing eco-friendly and sustainable buildings."
    ),
    Location(
        name: "Beckman Institute",
        coordinate: .beckmanInstitute,
        projectName: "Educational Robotics Curriculum",
        languages: ["Python", "Arduino", "Raspberry Pi"],
        description: "Curriculum development for teaching robotics to students."
    )
]



/// Generates a random latitude around Apple Park's latitude.
/// - Returns: A `Double` representing a random latitude.
func randomLatitude() -> Double {
    let baseLatitude: Double = 37.3349
    // Adjust the range to control how far from the base latitude the random values can be.
    let randomAdjustment = Double.random(in: -0.001...0.001) // Small range for nearby locations
    return baseLatitude + randomAdjustment
}

/// Generates a random longitude around Apple Park's longitude.
/// - Returns: A `Double` representing a random longitude.
func randomLongitude() -> Double {
    let baseLongitude: Double = -122.009020
    // Adjust the range to control how far from the base longitude the random values can be.
    let randomAdjustment = Double.random(in: -0.001...0.001) // Small range for nearby locations
    return baseLongitude + randomAdjustment
}



extension CLLocationCoordinate2D {
    static let techMuseum = CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0059)

    static let siebelCenter = CLLocationCoordinate2D(latitude: 40.1138, longitude: -88.2249) // Center
    static let eceb = CLLocationCoordinate2D(latitude: 40.1149, longitude: -88.2280) // Electrical and Computer Eng. Building
    static let graingerLibrary = CLLocationCoordinate2D(latitude: 40.1125, longitude: -88.2268) // Grainger Engineering Library
    static let mechSEBuilding = CLLocationCoordinate2D(latitude: 40.1124, longitude: -88.2265) // Mechanical Science & Engineering
    static let digitalComputerLab = CLLocationCoordinate2D(latitude: 40.1136, longitude: -88.2246) // Digital Computer Lab
    static let chemistryAnnex = CLLocationCoordinate2D(latitude: 40.1134, longitude: -88.2233) // Chemistry Annex
    static let newmarkCivilEng = CLLocationCoordinate2D(latitude: 40.1135, longitude: -88.2281) // Newmark Civil Engineering Lab
    static let beckmanInstitute = CLLocationCoordinate2D(latitude: 40.1140, longitude: -88.2225) // Beckman Institute for Advanced Science and Tech
}




extension MKCoordinateRegion {
    // Region centered around the UIUC campus
    static let uiucCampus = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.1138, // Approximate latitude for Siebel Center for CS
            longitude: -88.2249), // Approximate longitude for Siebel Center for CS
        span: MKCoordinateSpan(
            latitudeDelta: 0.05, // A smaller span to focus more closely on the campus area
            longitudeDelta: 0.05)
    )
    
    // A broader region to encompass the wider Urbana-Champaign area
    static let urbanaChampaign = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.1106, // General latitude for Urbana-Champaign
            longitude: -88.2073), // General longitude for Urbana-Champaign
        span: MKCoordinateSpan(
            latitudeDelta: 0.1, // A wider span to cover both Urbana and Champaign
            longitudeDelta: 0.1)
    )
}

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager() // Add LocationManager as an observed object

    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var searchResults: [MKMapItem] = []
    
    @State private var selectedLocation: Location? = nil
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(sampleLocations) { location in
                    Annotation("Project", coordinate: location.coordinate) {
                        CustomMarkerView {
                            selectedLocation = location
                        }
                        
                    }
                }
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)}
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
                .opacity(0.8)
            }
            .onChange(of: searchResults){
                position = .automatic
            }
            if let selectedLocation = selectedLocation {
                CustomPopupView(
                    title: selectedLocation.projectName,
                    languages: selectedLocation.languages,
                    description: selectedLocation.description,
                    dismissAction: {
                        withAnimation {
                            self.selectedLocation = nil
                        }
                    }
                )
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3)
            }



        }
    }
}

struct CustomMarkerView: View {
    let onTap: () -> Void
    
    var body: some View {
        Image(systemName: "mappin.circle.fill")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 30, height: 30)
            .onTapGesture(perform: onTap)
    }
}

struct CustomPopupView: View {
    var title: String
    var languages: [String]
    var description: String
    var dismissAction: () -> Void // Closure for dismissal action

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Spacer() // Use Spacer to push the button to the right
                Button(action: dismissAction) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                        .padding(4)
                }
            }
            FavoriteButtonView()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Capsule().fill(Color.blue))
                    }
                }
            }
            .frame(height: 40)

            Text(description)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeOut(duration: 0.3))
    }
}





   
#Preview {
    MapView()
}
