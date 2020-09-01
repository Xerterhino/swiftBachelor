//
//  StopWatchButton.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 16.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import SwiftUI

struct StopWatchButton : View {
    var actions: [() -> Void]
    var labels: [String]
    var color: Color
    var isPaused: Bool

    var body: some View {
        let buttonWidth = (UIScreen.main.bounds.size.width / 3) - 12
        
        return Button(action: {
                if self.isPaused {
                    self.actions[0]()
                } else {
                    self.actions[1]()
                }
            }) {
                if isPaused {
                    Text(self.labels[0])
                        .foregroundColor(Color.white)
                        .frame(width: buttonWidth,
                               height: 50)
                } else {
                    Text(self.labels[1])
                        .foregroundColor(Color.white)
                        .frame(width: buttonWidth,
                               height: 50)
                }
            }
            .background(self.color)
        }
}
    
struct StopWatchButton_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchButton(actions: [{print("action1")}, {print("action2")}],
        labels: ["Start", "Pause"],
        color: Color.blue,
        isPaused: true)
    }
}
