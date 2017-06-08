//
//  Universidade.swift
//  Exemplo CoreData
//
//  Created by labmacmini02 on 08/06/17.
//  Copyright © 2017 Unitins. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Universidade:NSManagedObject
{
    @NSManaged var nome:String
    @NSManaged var sigla: String
    @NSManaged var professores: Set<Professor>

    
    
    class func save(moc:NSManagedObjectContext, nome:String, sigla:String, professores:Array<Professor>)->Universidade?
    {
        
        if let novaUniversidade = NSEntityDescription.insertNewObject(forEntityName: "Universidade", into: moc) as? Universidade
        {
            novaUniversidade.nome = nome
            novaUniversidade.sigla = sigla
            novaUniversidade.professores = Set<Professor>()
            
            for universidade in professores
            {
                novaUniversidade.professores.insert(universidade)
            }
            
            novaUniversidade.save()

            return novaUniversidade
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
        return sigla.hashValue
    }

    class func getAll(moc:NSManagedObjectContext)->[Universidade]?
    {
        let request = NSFetchRequest<Universidade>(entityName: "Universidade")
        
        let classificacao = NSSortDescriptor(key: "sigla", ascending: true)
        
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







