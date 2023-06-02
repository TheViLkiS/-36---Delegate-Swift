//
//  ViewController.swift
//  №36 - Delegate в Swift
//
//  Created by Дмитрий Гусев on 31.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let engineer = Engineer()
        let manager = ProjectManager()
        engineer.delegate = manager
        manager.engineer = engineer
        
        manager.addTasksToEngineer()
        
        engineer.analize(requirements: ["r1", "r2"])
        engineer.startResearch("res")
        

    }
    
    


}

protocol EngineerDelegate: AnyObject {
    func taskHasEnded()
    func didFinishReserch(data: String)
    func didFinishAnalyzeRequirements(ressult: [String])
}



class Engineer {
    var task: Int = 0 {
        didSet {
            if task == 0 {
                delegate?.taskHasEnded()
            }
        }
    }
   weak var delegate: EngineerDelegate?
    
    func taskDone() {
        task -= 1
    }
    func startResearch(_ data: String = "") {
        //google
        //create document
        //rewiew doc
        delegate?.didFinishReserch(data: "document")
    }
    
    func analize(requirements: [String]) {
        //read
        //question
        //document
        delegate?.didFinishAnalyzeRequirements(ressult: ["q1", "q2"])
    }
    
}


class ProjectManager {
    
    var engineer: Engineer?
    
    func addTasksToEngineer(_ numberOfTasks: Int = 1) {
        engineer?.task += numberOfTasks
    }
    
}

extension ProjectManager: EngineerDelegate {
    func didFinishReserch(data: String) {
        addTasksToEngineer(2)
        print(data)
    }
    
    func didFinishAnalyzeRequirements(ressult: [String]) {
        print("Client: Clirify requirements \(ressult)")

    }

    func taskHasEnded() {
        print("Client: Give me tasks")
    }
}



// 1. protocol
// 2. obj1: property weak var delegate: ProtocolDelegate?
// 3. obj2: :ProtocolDelegate подписывается на протокол
// didFinish - что-то сделано в прошлом
