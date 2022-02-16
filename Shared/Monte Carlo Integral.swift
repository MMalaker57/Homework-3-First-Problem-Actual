//
//  File.swift
//  Homework 3 - Problem 1
//
//  Created by Matthew Malaker on 2/4/22.
//

import Foundation

class MonteCarloExp: NSObject, ObservableObject {
    
    
    func calculateEXPIntegral(lowerBound: Double, upperBound: Double, maximumGuesses: UInt64)->Double{
        let box = Bounding_Box()
        var numberOfGuesses = UInt64(0)
        var pointsUnderCurve = UInt64(0)
        var integral = 0.0
        var point = (xCoord: 0.0, yCoord: 0.0)
        var newPointsBelow: [(xCoord: Double, yCoord: Double)] = []
        var newPointsAbove: [(xCoord: Double, yCoord: Double)] = []
        
        //In order to do this integral, we need to generate a random point within the set bounds passed as arguments. We do not need to check the horizontal coordinates because the random generation is defined to be within the bounds, but the vertical coordinate does need to be checked. The horizontal is generated because the vertical depends on the horizontal
        while numberOfGuesses < maximumGuesses{
        
            point.xCoord = Double.random(in: lowerBound...upperBound)
            point.yCoord = Double.random(in: 0...exp(-1.0*lowerBound))
            
            
            //The integral is the area under the curve, so if under the curve, we need to add it to a counter specifically for that case.
            if(point.yCoord < exp(-1*point.xCoord)){
                pointsUnderCurve += 1
                newPointsBelow.append(point)
            }
            
            //If above the curve, do not add to below curve counter
            else{
                newPointsAbove.append(point)
            }
            numberOfGuesses += 1
        }
//        print(pointsUnderCurve)
        
//        integral = Double(pointsUnderCurve/numberOfGuesses)*box.cuboidVolume(numberOfSides: 2, sideOneDimension: upperBound-lowerBound, sideTwoDimension: exp(-1.0*lowerBound), sideThreeDimension: 0.0)
        
        integral = Double(pointsUnderCurve)/Double(numberOfGuesses)//*box.cuboidVolume(numberOfSides: 2, sideOneDimension: 1.0, sideTwoDimension: 1.0, sideThreeDimension: 0.0)
//        print(integral)
        return integral
        
        
    }
    
    func calculateRealIntegral(lowerBound: Double, upperBound: Double, exponentScale: Double) ->Double{
        
        let integralValue = (-1.0/exponentScale)*(exp(-1.0*exponentScale*upperBound)-exp(-1.0*exponentScale*lowerBound))
        return integralValue
    }
    
    func calculateIntegralError(passedLowerBound: Double, passedUpperBound: Double, passedExponentScale: Double, monteCarloValue: Double) -> Double{
        let realValue = calculateRealIntegral(lowerBound: passedLowerBound, upperBound: passedUpperBound, exponentScale: passedExponentScale)
        let error = (monteCarloValue - realValue) / realValue
        return error
        
    }
    
    
    
    
    
}
