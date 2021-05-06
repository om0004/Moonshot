//
//  Mission.swift
//  Moonshot
//
//  Created by om on 18/04/21.
//

import Foundation
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    var displayName:String
    {
        return "Apollo\(id)"
    }
    var image:String
    {
        return "apollo\(id)"
    }
    var formattedLaunchDate:String
    {
        if let x = launchDate
        {
            let formatter=DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from:x)
        }
        else
        {
            return "N/A"
        }
    }
    func showCrew(astronauts:[Astronaut])->String
    {
        var z=""
        for x in self.crew
        {
            if let match=astronauts.first(where:{$0.id == x.name})
            {
                z=z+match.name+"\n"
            }
        }
        return String(z.dropLast())
    }
}
