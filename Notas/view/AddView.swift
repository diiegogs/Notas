//
//  AddView.swift
//  Notas
//
//  Created by Juan Diego Garcia Serrano on 01/07/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.updateItems != nil ? "Editar nota" : "Agregar nota" )
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            TextEditor(text: $viewModel.nota)
            
            Divider()
            
            DatePicker("Seleccionar fecha", selection: $viewModel.fecha)
            
            Spacer()
            
            Button {
                if viewModel.updateItems != nil {
                    viewModel.editData(context: context)
                } else {
                    viewModel.saveData(context: context)
                }
            } label: {
                Label {
                    Text(viewModel.updateItems != nil ? "Editar" :"Guardar")
                        .foregroundStyle(.white)
                } icon: {
                    Image(systemName: viewModel.updateItems != nil ? "pencil" : "plus")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            .background(viewModel.nota.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(8.0)
            .frame(width: UIScreen.main.bounds.width - 30)
            .disabled(viewModel.nota.isEmpty ? true : false)
        }
        .padding()
    }
}
