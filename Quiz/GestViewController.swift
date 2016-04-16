//
//  GestViewController.swift
//  Quiz
//
//  Created by Admin on 16.04.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class GestViewController: UIViewController {

    //Знак ! означает что мы обещаем что
    //при обращении к этому свойству Вью1 будет существовать
    var view1: UIView!
    var imageView: UIImageView!
    
    //MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView1()
        setupImageView()
    
    
    }
    
    //MARK: - Setup
    //MARK: - View
    func setupView1(){
        view1 = UIView(frame:CGRect(x: 40, y: 40, width: 220, height: 300))
        view1.backgroundColor = UIColor(patternImage: UIImage(named: "fourthQuestion4")!)
        self.view.addSubview(self.view1)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureFired:")
    
        view1.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTapsRequired = 3 //три касания
        tapGesture.numberOfTouchesRequired = 2 //2 пальца
        
    }


    
    func tapGestureFired(gesture:UITapGestureRecognizer){
        print ("Fired!!!\(gesture)")
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view1.transform = CGAffineTransformRotate(self.view1.transform, CGFloat(M_PI_4))
        }
    
    }

    //MARK: - imageView
    func setupImageView(){
        imageView = UIImageView(image: UIImage(named: "fourthQuestion2"))
        view.addSubview(imageView)
        imageView.center = CGPoint(x: CGRectGetMidX(view.frame), y: CGRectGetMidY(view.frame))
       
        let panGesture = UIPanGestureRecognizer(target: self, action: "translateStalone:")
        imageView.addGestureRecognizer(panGesture)
        imageView.userInteractionEnabled = true
        //panGesture.numberOfTouchesRequired = 2
        
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "scaledStaloneFired:")
        imageView.addGestureRecognizer(pinchGesture)
        //imageView.userInteractionEnabled = true
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: "rotateStaloneFired:")
        imageView.addGestureRecognizer(rotateGesture)

        panGesture.delegate = self
        rotateGesture.delegate = self
        pinchGesture.delegate  = self
        
    }
 
    func translateStalone(gesture:UIPanGestureRecognizer){
        
        if(gesture.state == .Changed || gesture.state == .Ended)
        {
        //считаем перемещение
        var translation = gesture.translationInView(imageView)
        //print ("translated to: \(translation)")
        translation.x += imageView.center.x
        translation.y += imageView.center.y
        imageView.center = translation
        gesture.setTranslation(CGPointZero, inView: imageView)
        
        }
        
    }
    
    func scaledStaloneFired(gesture:UIPinchGestureRecognizer){
        switch gesture.state {
            
        case.Ended, .Changed:
            let scale = gesture.scale
            
            //let delta = (scale - 1)/2
            //let adjustedScale = 1 + delta
            //imageView.transform = CGAffineTransformScale(imageView.transform, adjustedScale, adjustedScale)
            let transformToApplay = CGAffineTransformMakeScale(scale, scale)
            let bounds = CGRectApplyAffineTransform(imageView.bounds, transformToApplay)
            imageView.bounds = bounds
            gesture.scale = 1

        
        default: break
        }
        
        
    }
    
    func rotateStaloneFired(gesture: UIRotationGestureRecognizer){
    
        switch gesture.state{
        case.Ended, .Changed:
            let rotation = gesture.rotation
            imageView.transform = CGAffineTransformRotate(imageView.transform, rotation)
            gesture.rotation = rotation
            gesture.rotation = 0

            
        default: break
        
        }
    }
    
    //extention GestViewController:
    
    
}


extension GestViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}




