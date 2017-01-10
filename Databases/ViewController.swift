//
//  ViewController.swift
//  Databases
//
//  Created by Mohit Kumar on 10/01/17.
//  Copyright © 2017 Mohit Kumar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    func loadData(){
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            print("Number of results:\(searchResults.count)")
            
            for result in searchResults as [Student]{
                print("\(result.firstName!) \(result.lastName!) is \(result.age) years old.")
            }
            
        }catch {
            print("Error \(error)")
        }
    }
    
    func saveData(){
        
        clearData()
        
        let studentClassName:String = String(describing: Student.self)
        let courseClassName:String = String(describing: Course.self)
        let student :Student = NSEntityDescription.insertNewObject(forEntityName: studentClassName, into: DatabaseController.getContext()) as! Student
        student.firstName = "Mohit"
        student.lastName = "Kumar"
        student.age = 22
        
        let course :Course = NSEntityDescription.insertNewObject(forEntityName: courseClassName, into: DatabaseController.getContext()) as! Course
        course.courseName = "Computer Science 402"
        
        student.addToCourses(course)
        //        course.addToStudents(student)
        
        DatabaseController.saveContext()
        
        loadData()
    }
    
    func clearData(){
        print("Inside Delete Data")
        
        let fetchReqest: NSFetchRequest<Student> = Student.fetchRequest()
        let context = DatabaseController.getContext()
            do{
                let students = try(context.fetch(fetchReqest))
                for student in students{
                    context.delete(student)
                }
            }catch{
                print("Error \(error)")
            }
        DatabaseController.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Loading")
        saveData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

