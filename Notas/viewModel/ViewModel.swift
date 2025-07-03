//
//  ViewModel.swift
//  Notas
//
//  Created by Juan Diego Garcia Serrano on 01/07/25.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published internal var nota: String = ""
    @Published internal var fecha: Date = Date()
    @Published internal var showModal: Bool = false
    
    @Published internal var updateItems: Notas?
    
    internal func saveData(context: NSManagedObjectContext) -> Void {
        let newNota = Notas(context: context)
        newNota.nota = self.nota
        newNota.fecha = self.fecha
        
        do {
            try context.save()
            print("se guardó el registro")
            DispatchQueue.main.async {
                self.showModal.toggle()
            }
        } catch let error {
            print("error al guardar el registro", error.localizedDescription)
        }
    }
    
    internal func deleteData(item: Notas, context: NSManagedObjectContext) -> Void {
        context.delete(item)
        
        do {
            try context.save()
            print("eliminado correctamente")
        } catch let error as NSError {
            print("error al eliminar registro: \(error.localizedDescription)")
        }
    }
    
    internal func sendData(items: Notas) -> Void {
        updateItems = items
        items.nota = nota
        items.fecha = fecha
        
        DispatchQueue.main.async {
            self.showModal.toggle()
        }
    }
    
    internal func editData(context: NSManagedObjectContext) -> Void {
        updateItems?.nota = nota
        updateItems?.fecha = fecha
        do {
            try context.save()
            print("editado correctamente")
            DispatchQueue.main.async {
                self.showModal.toggle()
            }
        } catch let error as NSError {
            print("error al editar registro: \(error.localizedDescription)")
        }
    }
}
