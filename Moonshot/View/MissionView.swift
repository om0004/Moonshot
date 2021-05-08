
//
//  MissionView.swift
//  Moonshot
//
//  Created by om on 19/04/21.
//

import SwiftUI

struct MissionView: View
{
    let mission:Mission
    var astronauts:[CrewMembers]
    struct CrewMembers
    {
        let role:String
        let astronaut:Astronaut
    }
    init(mission:Mission,astronauts:[Astronaut])
    {
        self.mission=mission
        var matches=[CrewMembers]()
        for member in mission.crew
        {
            if let match=astronauts.first(where:{$0.id == member.name})
            {
                matches.append(CrewMembers(role:member.role, astronaut:match))
            }
            else
            {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    var body: some View
    {
       
            GeometryReader
            {
                geo in
                ScrollView(.vertical)
                {
                    VStack
                    {
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:geo.size.width*0.7)
                            .padding(.top)
                        HStack
                        {
                        Text(self.mission.formattedLaunchDate)
                            .fontWeight(.bold)
                        Spacer()
                        }
                        .padding(.horizontal)
                        Text(self.mission.description)
                            .padding()
                        ForEach(self.astronauts,id: \.role)
                        {   crewMember in
                            NavigationLink(destination:AstronautView(astronaut:crewMember.astronaut))
                            {
                                HStack
                                {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        //.scaledToFit()
                                        .frame(width:166,height:120)
                                        .clipShape(RoundedRectangle(cornerRadius:10))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary, lineWidth: 1))
                                    VStack(alignment:.leading)
                                    {
                                            Text(crewMember.astronaut.name)
                                                .font(.headline)
                                        HStack
                                        {
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                            if crewMember.role == "Commander"
                                            {
                                                Image(systemName:"star.fill")
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                        Spacer(minLength: 25)
                        
                    }
                }
            }
            .navigationBarTitle(mission.displayName,displayMode:.inline)
        
    }
}

struct MissionView_Previews: PreviewProvider
{
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View
    {
        MissionView(mission:missions[1],astronauts:astronauts)
    }
}


