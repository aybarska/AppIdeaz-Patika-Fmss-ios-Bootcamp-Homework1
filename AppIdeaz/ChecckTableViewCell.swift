//
//  ChecckTableViewCell.swift
//  AppIdeaz
//
//  Created by Ayberk M on 7.09.2022.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
  func checkTableViewCell(_ cell: ChecckTableViewCell, didChagneCheckedState checked: Bool) // gonder
}

class ChecckTableViewCell: UITableViewCell {

    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: CheckTableViewCellDelegate? //bunu
    
   
    @IBAction func checked(_ sender: Checkbox) {
        updateChecked()
        delegate?.checkTableViewCell(self, didChagneCheckedState: checkbox.checked) //delegate fonk cagr
    }
    
    func set(title: String, checked: Bool) {
      label.text = title
      set(checked: checked)
    }
    
    func set(checked: Bool) {
      checkbox.checked = checked
      updateChecked()
    }
    
    private func updateChecked() {
      let attributedString = NSMutableAttributedString(string: label.text!)
      
      if checkbox.checked {
        attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
      } else {
        attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
      }
      
      label.attributedText = attributedString
    }
    
 
}
