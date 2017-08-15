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

    @IBAction func showAlert(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Hello, I'm alert! \n\n\n\n\n\n\n", message: "", preferredStyle: .alert)

        let rect        = CGRect(x: 15, y: 50, width: 240, height: 150.0)
        let textView    = UITextView(frame: rect)

        textView.font               = UIFont(name: "Helvetica", size: 15)
        textView.textColor          = UIColor.lightGray
        textView.backgroundColor    = UIColor.white
        textView.layer.borderColor  = UIColor.lightGray.cgColor
        textView.layer.borderWidth  = 1.0
        textView.text               = "Enter message here"
        textView.delegate           = self

        alertController.view.addSubview(textView)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in

            let msg = (textView.textColor == UIColor.lightGray) ? "" : textView.text

            print(msg)

        })
        alertController.addAction(cancel)
        alertController.addAction(action)

        self.present(alertController, animated: true, completion: {})

    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = ""
            textView.textColor = UIColor.darkGray
        }
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }

    @IBAction func showPopover(_ sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pc = storyboard.instantiateViewController(withIdentifier: "Popover") as? PopoverViewController
        pc?.modalPresentationStyle = .popover

        let popoverViewController = pc!.popoverPresentationController
        popoverViewController?.permittedArrowDirections = .any
        popoverViewController?.delegate = self
        popoverViewController?.sourceView = self.showPopoverButton
        popoverViewController?.sourceRect = CGRect(
            x: self.view.bounds.origin.x + 30,
            y: self.view.bounds.origin.y + 10,
            width: 1,
            height: 1)

        present(pc!, animated: true, completion: nil)

    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }


}

