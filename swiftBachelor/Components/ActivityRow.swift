//
//  ActivityRow.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 14.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import SwiftUI

struct ActivityRow: View {
    var activity: Activity;
    var count: String;
    var networkManager: NetworkManager;
    
    init(activity: Activity, netManager: NetworkManager) {
        self.networkManager = netManager;
        self.activity = activity
        self.count = "0"
        self.count = convertCountToTimeString(counter: Int(activity.duration)!)
        
    }

   
    func convertCountToTimeString(counter: Int) -> String {
        let millseconds = counter % 100
        var seconds = counter / 100
        let minutes = seconds / 60
        
        var millsecondsString = "\(millseconds)"
        var secondsString = "\(seconds)"
        var minutesString = "\(minutes)"
        
        if millseconds < 10 {
            millsecondsString = "0" + millsecondsString
        }
        
        if seconds > 59 {
            seconds = seconds - minutes * 60
            secondsString = "\(seconds)"
        }
        
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        
        return "\(minutesString):\(secondsString):\(millsecondsString)"
    }

    
    
    
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "clock")
            VStack(alignment: .leading) {
                Text(activity.name)
                Text(count
                ).font(.subheadline)
            

                Spacer()
                    NavigationLink(destination: ActivityDetailView(activity: activity)) {
                           EmptyView()
                    }.buttonStyle(DefaultButtonStyle())
                }
            Button(action: {}, label: {Image(systemName: "bin.xmark")})
                .onTapGesture {
                    self.networkManager.deleteActivity(activityID: self.activity._id)

            }
                
            }
            }.padding()
    }
}

struct ActivityRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ActivityRow(activity: activityData[0], netManager: NetworkManager())
            ActivityRow(activity: activityData[1], netManager: NetworkManager())
        
        }.previewLayout(.fixed(width: 300, height: 70))
        
        }
}
