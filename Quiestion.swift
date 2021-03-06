//
//  Quiestion.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

struct Question {
    
    let question:String
    let answers:[String]
    let correctAnswer:String
    private let imageName:String
    var image:UIImage? {
        return UIImage(named: imageName)
    }
    
    init(json:[String:AnyObject]) {
        
        question = json["question"] as! String
        answers  = json["answers"]  as! [String]
        correctAnswer = json["correctAnswer"] as! String
        imageName = json["image"] as! String
    }
    
    func isCorrectAnswer(answer:String?)->Bool {
        guard answer != nil else {
            return false
        }
        
        return correctAnswer == answer
    }
}
