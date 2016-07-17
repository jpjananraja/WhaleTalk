//
//  ChatCell.swift
//  WhaleTalk
//
//  Created by Janan Rajaratnam on 5/23/16.
//  Copyright © 2016 Janan Rajaratnam. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    let messageLabel : UILabel = UILabel()
    private let bubbleImageView = UIImageView()
    
    //AutoLayout constraints
//    private var outgoingConstraint: NSLayoutConstraint!
//    private var incomingConstraint: NSLayoutConstraint!
    
    
    //The above constraints have been phased out in place of an array of constraints below
    private var outgoingConstraints: [NSLayoutConstraint]!
    private var incomingConstraints: [NSLayoutConstraint]!
    
    
    //Override the initialisation code for the UITableViewCell so that we can customise the initialisation for ChatCell
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //Call the super class init function
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Set autoresizing to false because we are adding constraints in code
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false

        //Add the bubbleImageView to the Cell's contentView
        contentView.addSubview(bubbleImageView)
        
        //Add the messageLable to the bubbleImageview
        bubbleImageView.addSubview(messageLabel)
        
        
        //Set the constraints for the messageLabel and activate the constraints
        messageLabel.centerXAnchor.constraintEqualToAnchor(bubbleImageView.centerXAnchor).active = true
        messageLabel.centerYAnchor.constraintEqualToAnchor(bubbleImageView.centerYAnchor).active = true
        
        
        
        //Constraints that allow the speech bubble to grow with the text inside of it
        //Set the constraints and them activate them
        bubbleImageView.widthAnchor.constraintEqualToAnchor(messageLabel.widthAnchor, constant: 50).active = true //50 is added to take into account the speech bubble's tail
        
        //Add padding to the text by now including a "constant value" than the default function of constraintEqualToAnchor(messageLabel.heightAnchor)
        bubbleImageView.heightAnchor.constraintEqualToAnchor(messageLabel.heightAnchor, constant: 20).active = true
        
        
        
        //Phased out code to accomodate newer constraints
        //*******************************************************************************
        //Place the bubble at the right of the cell
        //bubbleImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
        //bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
        
        
        
        //The above trailingAnchor constraint is removed and instead the below constraints are used
        //outgoingConstraint = bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor)
        //incomingConstraint = bubbleImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor)
       //*******************************************************************************
        
        
        
        //New constraints in an array for the bubble image view
        outgoingConstraints = [bubbleImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
            bubbleImageView.leadingAnchor.constraintGreaterThanOrEqualToAnchor(contentView.centerXAnchor)
        ]
        
        incomingConstraints = [bubbleImageView.trailingAnchor.constraintLessThanOrEqualToAnchor(contentView.centerXAnchor),
            bubbleImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor)
        ]
        
        
        bubbleImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor, constant: 10).active = true
        bubbleImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor, constant: -10).active = true
        
        
        
        
        
        //Configure the UILabel
        messageLabel.textAlignment = .Center
        messageLabel.numberOfLines = 0 //Allows for multiple lines to be added dynamically
        
        
//        let image =  UIImage(named: "MessageBubble")?.imageWithRenderingMode(.AlwaysTemplate)
//        bubbleImageView.tintColor = UIColor.blueColor()
//        bubbleImageView.image = image
        //Instead of the above code, let the incoming function handle the images
        
    }
    
    
    //when we create a custom initializer, we should also call the following init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Check whether its an incoming or outgoing message
    func incoming(incoming: Bool){
        if incoming{
//            incomingConstraint.active = true
//            outgoingConstraint.active = false
            
            NSLayoutConstraint.deactivateConstraints(outgoingConstraints)
            NSLayoutConstraint.activateConstraints(incomingConstraints)
            
            bubbleImageView.image = bubble.incoming //extract the required tuple value using . notation
            
        }else{
//            incomingConstraint.active = false
//            outgoingConstraint.active = true
            
            NSLayoutConstraint.activateConstraints(outgoingConstraints)
            NSLayoutConstraint.deactivateConstraints(incomingConstraints)
            
            
            bubbleImageView.image = bubble.outgoing //extract the required tuple value using . notation

            
        }
        
        
    }
}

//Create the bubble constant using the makeBubble function
let bubble = makeBubble()


//Function that returns a tuple. Edge insets help dealing the chaotic distortion of the bubble
func makeBubble() -> (incoming: UIImage, outgoing: UIImage){
    let image = UIImage(named: "MessageBubble")!
    
    
    //The edge insets to deal with bubble distortion
    let insetsIncoming = UIEdgeInsets(top: 17, left: 26.5, bottom: 17.5, right: 21)
    let insetsOutgoing = UIEdgeInsets(top: 17, left: 21, bottom: 17.5, right: 26.5)
    
    
    //Old code that doesn't have edge insets, therefor distorts the bubble
//    let outgoing = coloredImage(image, red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
//    let flippedImage = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: UIImageOrientation.UpMirrored)
//    let incoming = coloredImage(flippedImage, red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    
    
    //New code that has edge insets that allows for proper resizing of bubble
    let outgoing = coloredImage(image, red: 0/255, green: 122/255, blue: 255/255, alpha: 1).resizableImageWithCapInsets(insetsOutgoing)
    let flippedImage = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: UIImageOrientation.UpMirrored)
    let incoming = coloredImage(flippedImage, red: 229/255, green: 229/255, blue: 229/255, alpha: 1).resizableImageWithCapInsets(insetsIncoming)
    
    
    //Return both the incoming and outgoing images as part of a tuple
    return (incoming, outgoing)
}



//function to create the colored image for the bubble
func coloredImage(image: UIImage, red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIImage{
    
    //create rectangle using CGRect with the size of the image
    let rect = CGRect(origin: CGPointZero, size: image.size)
    
    //The following creates a bitmap image context with the specified options
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    
    //The next two lines help creat the bitmap image context
    let context = UIGraphicsGetCurrentContext() //Provides the context to do the drawing
    image.drawInRect(rect)
    
    
    
    CGContextSetRGBFillColor(context, red, green, blue, alpha)
    CGContextSetBlendMode(context, CGBlendMode.SourceAtop)
    CGContextFillRect(context, rect)
    
    //Get the uiimage from the bitmap context
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return result
}


