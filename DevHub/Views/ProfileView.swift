//
//  ProfileView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/25/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack{
            VStack{
                Image("Git")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode:.fit)
                    .frame(width: 500, height:200)
                    
                Text("Jorge Alvarez")
                    .font(.largeTitle)
                    .bold()
                Text("GitHubAcc : JorgeA0")
                    .font(.body)
                    .bold()
                VStack{
                    HStack{
                        Text("Description:")
                            .font(.largeTitle)
                            .bold()
                    }
                    Text("Hello, my name is Jorge and I am interested in Software Engineering. I am a Junior and this is my first Hackathon.")
                        .font(.body)
                        .padding(2)
                        .bold()

                    Spacer()
                }
                .padding()
            }
        }
    }
}
#Preview {
    ProfileView()
}
