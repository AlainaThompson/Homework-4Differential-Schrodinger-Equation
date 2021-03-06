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
    @State var xMax: String = "10.0"
    @State var isChecked:Bool = false
  
    
    
    
    @State var potentialTypes = ["Square Well", "Linear Well", "Parabolic Well", "Square+Linear", "Square Barrier", "Triangle Barrier", "Coupled Parabolic Well", "Coupled Square Well + Field", "Harmonic Oscillator", "Kronig Penny", "Variable Kronig Penny", "KP2-a"]
    @State var selectedPotential = "Square Well"

    //How to make an energy picker that is dependent upon results of potentialType?

    
    
    
    

    var body: some View {
        
    

        
        
        VStack{
      
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            
            Picker("Potential:", selection: $selectedPotential) {
                ForEach(potentialTypes, id: \.self) {
                    Text($0)
                    
                }
            
            }
           
            
            
            HStack{
                
                HStack(alignment: .center) {
                    Text("Box Length")
                        .font(.callout)
                        .bold()
                    TextField("length value", text: $xMax)
                        .padding(.bottom, 5.0)
                }.padding()
                
                
            }
            
          
            
            
            HStack{
                Button("Calculate potential", action: {
                    
                    self.calculatePotential()} )
                .padding()
                
            }
            
            HStack{
                Button("Calculate wavefunction", action: {self.calculateWaveFunction()} )
                .padding()
                
            }
            HStack{
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                    
            }
            
            
        }
        
    }
    
    
   
    
    
    func calculatePotential(){
        
      
        
        myPotential.plotDataModel = self.plotDataModel
        
        myPotential.getPotential(xMin: 0.0, xMax: 10.0, xStep: 0.01, selectedPotential: selectedPotential)
        
        
        
        
        
        
    }
    
    func calculateWaveFunction(){
        self.calculatePotential()
       
        myDiff.PotentialData = myPotential
        
        myDiff.plotDataModel = self.plotDataModel
        
        myDiff.calculateRK4(E: 0.376, xMax: 10.0, xMin: 0.0, xStep: 0.01)
       
        
       
        
        
    }

    func clear(){
            
        myPotential.plotPotentialData.removeAll()
        myDiff.x_array = []
        myDiff.psi_array = []
        myDiff.psi_prime_array = []
            
            
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
