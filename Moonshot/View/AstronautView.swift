//
//  AstronautView.swift
//  Moonshot
//
//  Created by om on 20/04/21.
//

import SwiftUI

struct AstronautView: View
{
    let astronaut:Astronaut
    var missions:[Mission]
    init(astronaut:Astronaut)
    {
        self.astronaut=astronaut
        let x:[Mission]=Bundle.main.decode("missions.json")
        var new=[Mission]()
        for mission in x
        {
            if let _ = mission.crew.first(where:{$0.name == astronaut.id})
            {
                new.append(mission)
            }
        }
        missions=new
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
                Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width:geo.size.width)
                Text(astronaut.description)
                    .padding()
                ForEach(missions)
                {
                   x in
                    HStack
                    {
                        Image(x.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:160,height:120)
                        Text(x.displayName)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                    //.layoutPriority(1)
            }
        }
       }
       .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[Astronaut]=Bundle.main.decode("astronauts.json")
    //static let missions:[Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut:astronauts[7])
    }
}
