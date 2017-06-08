//
//  Professor.swift
//  Exemplo CoreData
//
//  Created by labmacmini02 on 08/06/17.
//  Copyright © 2017 Unitins. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Professor: NSManagedObject
{
    @NSManaged var nome:String
    @NSManaged var matricula: Int32
    @NSManaged var universidades: Set<Universidade>
    
    class func save(moc:NSManagedObjectContext, nome:String, matricula:Int32, universidades:Array<Universidade>)->Professor?
    {
        if let novoProfessor = NSEntityDescription.insertNewObject(forEntityName: "Professor", into: moc) as? Professor
        {
            novoProfessor.nome = nome
            novoProfessor.matricula = matricula
            novoProfessor.universidades = Set<Universidade>()
            
            for professor in universidades
            {
                novoProfessor.universidades.insert(professor)
            }
            
            novoProfessor.save()
            
            return novoProfessor
        }
        
        return nil
    }
    
    func delete()
    {
        managedObjectContext?.delete(self)
        self.save()
    }
    
    func save()
    {
        do{
            try managedObjectContext?.save()
        }
        catch{}
    }
    
    override var hashValue: Int
    {
      return matricula.hashValue
    }
    
    class func getAll(moc:NSManagedObjectContext)->[Professor]?
    {
        let request = NSFetchRequest<Professor>(entityName: "Professor")
        
        let classificacao = NSSortDescriptor(key: "nome", ascending: true)
        
        request.sortDescriptors = [classificacao]
        
        do
        {
            return try moc.fetch(request)
        }
        catch
        {
        }
        return nil
    }
    
    
}











