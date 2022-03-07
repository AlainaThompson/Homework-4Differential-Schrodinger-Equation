//
//  DIff_Schrodinger_Eq_App.swift
//  Shared
//
//  Created by Alaina Thompson on 3/4/22.
//

import SwiftUI

@main
struct DIff_Schrodinger_Eq_App: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
