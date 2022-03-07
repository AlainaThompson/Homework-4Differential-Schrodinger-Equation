//
//  ContentView.swift
//  Shared
//
//  Created by Alaina Thompson on 3/4/22.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    @ObservedObject var myPotential = Potential()
    @ObservedObject var myDiff = DiffEq()
    @State var xInput: String = "\(Double.pi/2.0)"
    @State var cosOutput: String = "0.0"
    @State var computerCos: String = "\(cos(Double.pi/2.0))"
    @State var error: String = "0.0"
    @State var isChecked:Bool = false
  
    

    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("x:")
                        .font(.callout)
                        .bold()
                    TextField("xValue", text: $xInput)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("cos(x):")
                        .font(.callout)
                        .bold()
                    TextField("cos(x)", text: $cosOutput)
                        .padding()
                }.padding()
                
                Toggle(isOn: $isChecked) {
                            Text("Display Error")
                        }
                .padding()
                
                
            }
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("Expected:")
                        .font(.callout)
                        .bold()
                    TextField("Expected:", text: $computerCos)
                        .padding()
                }.padding()
                
                HStack(alignment: .center) {
                    Text("Error:")
                        .font(.callout)
                        .bold()
                    TextField("Error", text: $error)
                        .padding()
                }.padding()
            
                
            }
            
            
            HStack{
                Button("Calculate potential", action: {self.calculatePotential()} )
                .padding()
                
            }
            
            HStack{
                Button("Calculate wavefunction", action: {self.calculateWaveFunction()} )
                .padding()
                
            }
        }
        
    }
    
    
    
    
    /// calculateCos_X
    /// Function accepts the command to start the calculation from the GUI
    func calculatePotential(){
        
      
        
        //pass the plotDataModel to the cosCalculator
        myPotential.plotDataModel = self.plotDataModel
        
        myPotential.SetPotential(xMin: 0.0, xMax: 10.0, xStep: 0.01, PotentialType: "Square Well")
     
        
    }
    
    func calculateWaveFunction(){
        self.calculatePotential()
       
        myDiff.PotentialData = myPotential
        
      
        myDiff.plotDataModel = self.plotDataModel
        myDiff.calculateRK4(E: 0.376, xMax: 10.0, xMin: 0.0, xStep: 0.01)
       
        
        
    }

   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
