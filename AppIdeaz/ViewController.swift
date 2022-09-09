//
//  ViewController.swift
//  AppIdeaz
//
//  Created by Ayberk M on 7.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var ideaz = [
        Ideaz(title: "app ideas app", isEvaluated: false, image: "fotiyukle.png", description: "App that can hold app ideas..."),
        Ideaz(title: "only sum calculator", isEvaluated: false, image: "fotiyukle.png", description: "takes 2 numbers and bum"),
        Ideaz(title: "sayginlik kazanilacak", isEvaluated: false, image: "rcpivdk.png", description: "3")
    ]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // view render olduktan sonra yapilacaklar
    }


    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBSegueAction func ideaViewcontroller2(_ coder: NSCoder) -> IdeaViewController? {
        let vc = IdeaViewController(coder: coder)
        vc?.delegate = self
        return vc
    }
    
    @IBSegueAction func ideaViewcontroller(_ coder: NSCoder) -> IdeaViewController? {
        let vc = IdeaViewController(coder: coder) // atama
        if let indexpath = tableView.indexPathForSelectedRow {
            let idea = ideaz[indexpath.row]
            vc?.idea = idea
        }
        vc?.delegate = self
        return vc
    }
    
}

extension ViewController: UITableViewDataSource { //bunu ezberle
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideaz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! ChecckTableViewCell
        cell.delegate = self
        
       // let cell = ChecckTableViewCell() // custom cell storyboard tarafinda olusturdugum icin boyle gelmezmis
        let idea = ideaz[indexPath.row]
        //cell.textLabel?.text = idea.title
        
        cell.set(title: idea.title, checked: idea.isEvaluated)
        
        return cell
    }
    
    //DTsource metodlari ornekler
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete { //silmek
        ideaz.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      let idea = ideaz.remove(at: sourceIndexPath.row)
      ideaz.insert(idea, at: destinationIndexPath.row) // reorder icin fakat source a bi sey yapmiyor.
    }
    
    
}

extension ViewController: CheckTableViewCellDelegate {
  
  func checkTableViewCell(_ cell: ChecckTableViewCell, didChagneCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let idea = ideaz[indexPath.row]
    let newIdea = Ideaz(title: idea.title, isEvaluated: checked, image: "",description: "")  // tut
    
    ideaz[indexPath.row] = newIdea
  }
  
}

extension ViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
          
          let idea = self.ideaz[indexPath.row].completeToggled()
          self.ideaz[indexPath.row] = idea
           
          let cell = tableView.cellForRow(at: indexPath) as! ChecckTableViewCell
          cell.set(checked: idea.isEvaluated)
          
          complete(true)
          
          print("kaydir ciz")
    }
        return UISwipeActionsConfiguration(actions: [action])
  
}
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .delete //kendi ozelligi
    }
}

extension ViewController: IdeaViewControllerDelegate { 
  
  func ideaViewController(_ vc: IdeaViewController, didSaveIdea idea: Ideaz) {
    
    
    
    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        // update yeri
        self.ideaz[indexPath.row] = idea
        self.tableView.reloadRows(at: [indexPath], with: .none)
      } else {
        // create yeri
        self.ideaz.append(idea)
        self.tableView.insertRows(at: [IndexPath(row: self.ideaz.count-1, section: 0)], with: .automatic)
      }
    }
  }
  
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
}
