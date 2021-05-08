//
//  ContentView.swift
//  Moonshot
//
//  Created by om on 17/04/21.
//

import SwiftUI

struct ContentView: View
{
    let astronauts:[Astronaut]=Bundle.main.decode("astronauts.json")
    let missions:[Mission]=Bundle.main.decode("missions.json")
    @State private var showDate=true
    var body: some View
    {
        NavigationView
        {
            List(missions)
            {
                mission in
                NavigationLink(destination:MissionView(mission:mission,astronauts:astronauts))
                {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:44,height:44)
                    VStack(alignment:.leading)
                    {
                        Text(mission.displayName)
                            .font(.headline)
                        if showDate
                        {
                            Text(mission.formattedLaunchDate)
                        }
                        if !showDate
                        {
                            Text("\(mission.showCrew(astronauts:astronauts))")
                        }
                    }
                    
                }
            }
            .navigationBarItems(trailing:Button(showDate ? "Show Crew" : "Show Date")
            {
                self.showDate.toggle()
            })
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
