//
//  ContentView.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 14.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import SwiftUI
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }

}
struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State var activityName: String = "";
    @State var selectedAc = Activity(_id: "a", name: "asd", duration: "0")
    @State var selection: Int? = nil
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func showNoti() {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()

        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Check your activities"
        //content.subtitle = "Lunch"
        content.body = "Did you track anything today?"
        content.sound = UNNotificationSound.default

        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier1", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
        VStack {
            Button(action: {
                self.networkManager.loadDataNormal();
            }) {
                Text("Update")
            }
            ActivityListView()
            
            HStack {
                TextField("Acitivity Name", text: $activityName)
                NavigationLink(destination: ActivityDetailView(activity: Activity(_id: self.networkManager.createdActivity._id, name: self.networkManager.createdActivity.name, duration: "0")), tag: 1, selection: $selection) {
                    Button(action:{
                        
                           let selectedAc = self.networkManager.createActivity(activityName: self.activityName) ?? Activity(_id: "a", name: "A", duration: "0");
                        print("SELECTED", selectedAc)
                        self.selection  = 1;
                        
                    }) {
                        Text("ADD")
                    }
                }
                

            }.padding()
        }.padding().navigationBarTitle(Text("Activities"))
        }.onAppear(perform: {
        print("APPEARED")
        //self.showNoti()
            
        })
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
