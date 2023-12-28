//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {

    @State var repairsArray = Repair.repairsMocked

    var body: some View {
        
        NavigationStack{
                List(repairsArray) { item in
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
                .toolbarBackground(Color(.white), for: .navigationBar)
                .toolbar {
                    Button("+") {
                        print("+ tapped")
                    }
                    .padding()
                    .font(.largeTitle)
                }
                
                
        }
        
    }
}

#Preview {
    RelpairsListView()
}


