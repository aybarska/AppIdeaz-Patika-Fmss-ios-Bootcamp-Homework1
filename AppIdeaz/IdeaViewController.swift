//
//  IdeaViewController.swift
//  AppIdeaz
//
//  Created by Ayberk M on 8.09.2022.
//

import UIKit

protocol IdeaViewControllerDelegate: AnyObject {
  func ideaViewController(_ vc: IdeaViewController, didSaveIdea idea: Ideaz)
}


class IdeaViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    
    var idea: Ideaz?
    weak var delegate: IdeaViewControllerDelegate?
    
    override func viewDidLoad() {
      super.viewDidLoad()

      textfield.text = idea?.title
    }

    @IBAction func save(_ sender: Any) {
        if textfield.text == "" { //text bos donunce app crash oluyordu
        //modal kapa
            self.dismiss(animated: true, completion: nil)
            
        } else {
            let idea = Ideaz(title: textfield.text!, image: "", description: "")
          //  let idea = Ideaz(title: "", image: "", description: "")
            delegate?.ideaViewController(self, didSaveIdea: idea)
        }

    }
}
