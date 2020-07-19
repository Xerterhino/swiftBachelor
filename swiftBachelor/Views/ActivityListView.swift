//
//  ActivityList.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 15.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import SwiftUI

struct ActivityListView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
        List (networkManager.activities, id: \._id) { activity in
            ActivityRow(activity: activity, netManager: self.networkManager)
        }
        
        
    }
}


struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
