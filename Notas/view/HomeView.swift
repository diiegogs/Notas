//
//  HomeView.swift
//  Notas
//
//  Created by Juan Diego Garcia Serrano on 01/07/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel: ViewModel = ViewModel()
//    @FetchRequest(
//        entity: Notas.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(key: "fecha", ascending: true)], animation: .interactiveSpring()) var result: FetchedResults<Notas>
    
    @FetchRequest(
        entity: Notas.entity(),
        sortDescriptors: [],
//        BEGINSWITH
//        CONTAINS
//        ...
        predicate: NSPredicate(format: "nota CONTAINS 'IMPORTANTE'"),
        animation: .bouncy) var result: FetchedResults<Notas>
    
    var body: some View {
        NavigationView {
            VStack {
                if result.isEmpty {
                    VStack(alignment: .center) {
                        Text("Sin notas")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    List {
                        ForEach(result) { content in
                            VStack(alignment: .leading) {
                                Text(content.nota ?? "")
                                    .font(.title)
                                    .bold()
                                
                                Text(content.fecha ?? Date(), style: .date)
                                    .font(.title2)
                            }
                            .contextMenu(
                                ContextMenu(
                                    menuItems: {
                                        Button { [weak viewModel] in
                                            viewModel?.deleteData(item: content, context: context)
                                        } label: {
                                            Label {
                                                Text("Eliminar")
                                            } icon: {
                                                Image(systemName: "trash")
                                            }
                                            
                                        }
                                        
                                        Button {
                                            viewModel.sendData(items: content)
                                        } label: {
                                            Label {
                                                Text("Editar")
                                            } icon: {
                                                Image(systemName: "pencil")
                                            }
                                        }
                                    }
                                )
                            )
                            
                        }
                    }
                }
            }
            .navigationTitle("Notas")
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.showModal.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showModal) {
                AddView(viewModel: viewModel)
            }
        }
    }
}
