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
    @IBOutlet weak var checkbox22: Checkbox!
    @IBOutlet weak var Description: UITextField!
    
    var idea: Ideaz?
    weak var delegate: IdeaViewControllerDelegate?
    
    
    override func viewDidLoad() {
      super.viewDidLoad()

        textfield.text = idea?.title
        checkbox22.checked = idea!.isEvaluated //bu niye forced derste sorulacak
        Description.text = idea?.description
       // print(idea!.isEvaluated) //geliyr
       // print(checkbox22.checked) //dogru
    }

    @IBAction func save(_ sender: Any) {
        if textfield.text == "" { //text bos donunce app crash oluyordu
        //modal kapa
            self.dismiss(animated: true, completion: nil)
            
        } else {
            let idea = Ideaz(title: textfield.text!, isEvaluated: checkbox22.checked, image: "", description: Description.text ?? "default value")
          //  let idea = Ideaz(title: "", image: "", description: "")
            delegate?.ideaViewController(self, didSaveIdea: idea)
        }

    }
}
