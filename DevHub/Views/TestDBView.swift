//
//  TestDBView.swift
//  DevHub
//
//  Created by Milind Maiti on 2/24/24.
//

import SwiftUI
import FirebaseFirestore

struct TestDBView: View {
    @State private var userName: String = ""
    @State private var userDescription: String = ""
    @State private var userRepo: String = ""
    @State private var longitude: Int = 0
    @State private var latitude: Int = 0
    
    var projectTags = ["iOS", "Android", "Beginner", "Intermediate", "Advanced", "Web", "Cool", "Not cool"]
    
    @State private var chosenTags = Set<String>()
    var body: some View {
        VStack {
            Text("Post Project")
                .padding()
                .bold()
            TextField("Project Name", text: $userName)
                .padding()
            TextField("Description", text: $userDescription, axis: .vertical)
                .padding()
            TextField("Github Repo Link", text: $userRepo, axis: .vertical)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(projectTags, id: \.self) { item in
                        Button(action: { if(chosenTags.contains(item))
                            {
                            chosenTags.remove(item)
                        }
                            else{
                                chosenTags.insert(item)
                            }
                            
                            print(chosenTags)
                        }){
                            Text(item)
                                .foregroundColor(.white)
                                .padding()
                                .background(chosenTags.contains(item) ? Color.green : Color.blue)
                                .cornerRadius(10)
                            
                        }
                    }
                }
            }
            Button("Add Project") {
                addUser()
            }
            .padding()
        }
        .padding()
    }
    
    func addUser() {
        let db = Firestore.firestore()
        
        
        // Create a new user document
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": userName,
            "description": userDescription,
            "Github": userRepo,
            "Longitude": longitude,
            "Latitude": latitude,
            "Tags": Array(chosenTags)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                // Optionally, clear the form fields
                userName = ""
                userDescription = ""
                userRepo = ""
            }
        }
    }
}

#Preview {
    TestDBView()
}
