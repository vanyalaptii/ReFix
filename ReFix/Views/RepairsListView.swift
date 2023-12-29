//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {

    @State var repairsArray = Repair.repairsMocked
    
    @State private var searchText = ""
    @State private var searchIsActive = false

    var body: some View {
        
        NavigationStack{
            List(searchResults) { item in
                ZStack {
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading, content: {
                            Text(item.model)
                                .font(.system(size: 17))
                                .padding(1)
                            Text("#\(item.id)")
                                .font(.system(size: 15))
                                .foregroundStyle(.secondary)
                        })
                        
                        Spacer()
                        
                        HStack {
                            Text("Detail")
                                .font(.system(size: 17))
                                .font(.system(.title3))
                                .foregroundStyle(.secondary)
                            
                            Image(systemName: "chevron.right")
                                .opacity(0.5)
                        }
                    }
                    .padding(.horizontal)
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
                }
                .listRowSeparator(.hidden)
                
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Ремонти")
            .toolbar {
                Button("+") {
                    print("+ tapped")
                }
                .padding()
                .font(.largeTitle)
            }
            .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "Пошук")
        }
    }
    
    var searchResults: [Repair] {
            if searchText.isEmpty {
                return repairsArray
            } else {
                return repairsArray.filter { $0.model.contains(searchText) }
                     + repairsArray.filter { $0.brand.contains(searchText) }
                     + repairsArray.filter { $0.id.description.contains(searchText) }
                     + repairsArray.filter { $0.client.name.contains(searchText) }
                     + repairsArray.filter { $0.client.phoneNumber.contains(searchText)}
            }
        }
}

#Preview {
    RelpairsListView()
}


