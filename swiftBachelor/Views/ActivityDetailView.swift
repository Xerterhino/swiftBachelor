//
//  ActivityDetailView.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 15.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import SwiftUI



struct ActivityDetailView: View {
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var stopWatch: StopWatch
    
    var activity: Activity;
    
    @State private var activityName: String;
    @State var selection: Int? = nil
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    init( activity: Activity) {
        self.activity = activity
        _activityName = State(initialValue: activity.name)
        self.stopWatch = StopWatch(duration: Int(activity.duration) ?? 0)
        self.stopWatch.update()
    }
    
    
    
    
    var body: some View {
        
            VStack {
                
                VStack {
                    Text(stopWatch.stopWatchTime)   .font(.custom("courier", size: 70))
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: 250,
                               alignment: .center)
                }
                HStack {
                    StopWatchButton(actions: [self.stopWatch.reset, self.stopWatch.reset],
                                    labels: ["Reset", "Reset"],
                                    color: Color.yellow,
                                    isPaused: self.stopWatch.isPaused())
                    
                    StopWatchButton(actions: [self.stopWatch.pause, self.stopWatch.pause],
                                    labels: ["Stop", "Stop"],
                                    color: Color.red,
                                    isPaused: self.stopWatch.isPaused())
                    
                    StopWatchButton(actions: [self.stopWatch.start, self.stopWatch.start],
                                    labels: ["Start", "Start"],
                                    color: Color.blue,
                                    isPaused: self.stopWatch.isPaused())
                }
                Button(action: {self.networkManager.updateActivity(activityID: self.activity._id, activityName: self.activityName, duration: String(self.stopWatch.counter))
                    
                    self.mode.wrappedValue.dismiss()
                    // self.selection = 1
                }){
                    Text("Save")
                }.foregroundColor(Color.white)
                    .frame(width: (UIScreen.main.bounds.size.width / 2) - 12,
                           height: 50).background(Color.green).padding()
                
                TextField("Acitivity Name", text: $activityName).padding().textFieldStyle(RoundedBorderTextFieldStyle())
                
               }
    }
    
}



struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: activityData[0])
    }
}
