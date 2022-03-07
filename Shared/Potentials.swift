//
//  Potentials.swift
//  DIff Schrodinger Eq.
//
//  Created by Alaina Thompson on 3/4/22.
//

import Foundation
import SwiftUI

class Potential: ObservableObject{
    var plotDataModel: PlotDataClass? = nil
    @Published var x:[Double] = []
    @Published var V:[Double] = []
    
    var plotPotentialData :[plotDataType] =  []
    
    func startPotential(xMin: Double, xMax: Double, xStep: Double) {
        var count = 0
        var dataPoint: plotDataType = [.X: 0.0, .Y: 0.0]
        x.append(xMin)
        V.append(50000000.0)
        count = x.count
        dataPoint = [.X: x[count-1], .Y: V[count-1]]
        plotPotentialData.append(dataPoint)
        
    }
    
    func finishedPotential(xMin: Double, xMax: Double, xStep: Double) {
        var count = 0
        var dataPoint: plotDataType = [.X: 0.0, .Y: 0.0]
        x.append(xMax)
        V.append(50000000.0)
        count = x.count
        dataPoint = [.X: x[count-1], .Y: V[count-1]]
        plotPotentialData.append(dataPoint)
    }
    
    func SetPotential(xMin: Double, xMax: Double, xStep: Double, PotentialType: String) {
        var count = x.count
        var dataPoint: plotDataType = [.X: 0.0, .Y: 0.0]
        
        plotPotentialData.append(dataPoint)
        plotPotentialData.removeAll()
        
        
        switch PotentialType {
                case "Square Well":
                    
            startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
            
        for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
            
            x.append(i)
            V.append(0.0)
            
            count = x.count
            dataPoint = [.X: x[count-1], .Y: V[count-1]]
            plotPotentialData.append(dataPoint)
        }
            
            finishedPotential(xMin: xMin, xMax: xMax, xStep: xStep)
        
            makeDataForPlot()
            
            
            
                    
                    
               
                default:
                   
            startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
            
        for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
            
            x.append(i)
            V.append(0.0)
            
            count = x.count
            dataPoint = [.X: x[count-1], .Y: V[count-1]]
            plotPotentialData.append(dataPoint)
        }
            
            finishedPotential(xMin: xMin, xMax: xMax, xStep: xStep)
        
            makeDataForPlot()
            
            
            }
            

            
            
            
    }
    
    func makeDataForPlot() {
        plotDataModel!.zeroData()

        plotDataModel!.calculatedText = "The Potential is: \n"
                plotDataModel!.calculatedText += "x and V \n"
                
              


                
                    //set the Plot Parameters
                    plotDataModel!.changingPlotParameters.yMax = 18.0
                    plotDataModel!.changingPlotParameters.yMin = -18.1
                    plotDataModel!.changingPlotParameters.xMax = 15.0
                    plotDataModel!.changingPlotParameters.xMin = -1.0
                    plotDataModel!.changingPlotParameters.xLabel = "n"
                    plotDataModel!.changingPlotParameters.yLabel = "Abs(log(Error))"
                    plotDataModel!.changingPlotParameters.lineColor = .red()
                    plotDataModel!.changingPlotParameters.title = "Error cos(x) vs n"
                        
        for i in 0..<x.count {
        plotDataModel!.calculatedText += "\(x[i]), \t\(V[i])\n"
        
                    let dataPoint: plotDataType = [.X: x[i], .Y: V[i]]
                    plotDataModel!.appendData(dataPoint: [dataPoint])
                    
                
        }
    }
    
    
}
