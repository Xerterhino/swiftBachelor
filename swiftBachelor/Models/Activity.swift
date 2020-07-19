/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import CoreLocation



struct Activity: Codable{
    
    var _id: String
    var name: String
    var duration: String
}

struct ActivityList: Decodable {
  var results: [Activity]
}
