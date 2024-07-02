//
//  ContentView.swift
//  DEVOTE
//
//  Created by vinay Kumar ranjan on 07/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                }
                .onDelete(perform: deleteItems)
            }
            
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
#endif
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                        
                    }
                }
            }
        }
        
    }
    func addItem() {
        withAnimation{
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
      withAnimation {
        offsets.map { items[$0] }.forEach(viewContext.delete)
        
        do {
          try viewContext.save()
        } catch {
          let nsError = error as NSError
          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
      }
    }
    
    
}

#Preview {
    ContentView()
}
