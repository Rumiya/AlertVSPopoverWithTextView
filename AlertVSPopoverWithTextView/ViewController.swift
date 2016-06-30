//
//  ViewController.swift
//  AlertVSPopoverWithTextView
//
//  Created by Rumiya Murtazina on 6/4/16.
//  Copyright © 2016 abearablecode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIPopoverPresentationControllerDelegate {


    @IBOutlet weak var showPopoverButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "Hello, I'm alert! \n\n\n\n\n\n\n", message: "", preferredStyle: .Alert)

        let rect        = CGRectMake(15, 50, 240, 150.0)
        let textView    = UITextView(frame: rect)

        textView.font               = UIFont(name: "Helvetica", size: 15)
        textView.textColor          = UIColor.lightGrayColor()
        textView.backgroundColor    = UIColor.whiteColor()
        textView.layer.borderColor  = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth  = 1.0
        textView.text               = "Enter message here"
        textView.delegate           = self

        alertController.view.addSubview(textView)

        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: { action in

            let msg = (textView.textColor == UIColor.lightGrayColor()) ? "" : textView.text

            print(msg)

        })
        alertController.addAction(cancel)
        alertController.addAction(action)

        self.presentViewController(alertController, animated: true, completion: {})

    }

    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor(){
            textView.text = ""
            textView.textColor = UIColor.darkGrayColor()
        }
    }

    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }

    @IBAction func showPopover(sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pc = storyboard.instantiateViewControllerWithIdentifier("Popover") as? PopoverViewController
        pc?.modalPresentationStyle = .Popover

        let popoverViewController = pc!.popoverPresentationController
        popoverViewController?.permittedArrowDirections = .Any
        popoverViewController?.delegate = self
        popoverViewController?.sourceView = self.showPopoverButton
        popoverViewController?.sourceRect = CGRect(
            x: self.view.bounds.origin.x + 30,
            y: self.view.bounds.origin.y + 10,
            width: 1,
            height: 1)

        presentViewController(pc!, animated: true, completion: nil)

    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }


}

