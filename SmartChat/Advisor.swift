//
//  Advisor.swift
//  SmartChat
//
//  Created by riccardo ruocco on 01/04/22.
//

import Foundation
import NaturalLanguage
import CoreML

class Advisor{
    
    var model:MLModel? = nil
    var predictor:NLModel? = nil
     init(){
         do{
             model = try TripleTextClassifier2_0(configuration: MLModelConfiguration()).model
            predictor = try NLModel(mlModel: model!)
         }
         catch{
             
         }

    }
    
    func getClassification(data:String)->String{
        var labelToReturn = predictor?.predictedLabel(for: data)
        return labelToReturn!
    }
    
    
}
