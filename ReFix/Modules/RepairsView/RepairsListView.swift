//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {
    
    @StateObject var viewModel = RepairsListViewModel()
    
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
                        
                        details
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
                    viewModel.addNewRepairIsPresented = true
                }
                .padding()
                .font(.largeTitle)
                .sheet(isPresented: $viewModel.addNewRepairIsPresented) {
                    AddNewRepairView()
                        .environmentObject(viewModel)
                        .presentationDetents([.large, .fraction(0.08)], selection: .constant(.large))
                        .presentationBackgroundInteraction(.enabled)
                        .presentationCompactAdaptation(.sheet)
                }
            }
            .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "Пошук")
        }
        .onAppear {
            Task {
                try await viewModel.loadCurrentUser()
                await viewModel.loadRepairsArray()
            }
        }
    }
    
    var searchResults: [Repair] {
        if searchText.isEmpty {
            return viewModel.repairListArray
        } else {
            return viewModel.repairListArray.filter { $0.model.contains(searchText) }
                 + viewModel.repairListArray.filter { $0.brand.contains(searchText) }
                 + viewModel.repairListArray.filter { $0.id.description.contains(searchText) }
//                 + repairsArray.filter { $0.client.name.contains(searchText) }
//                 + repairsArray.filter { $0.client.phoneNumber.contains(searchText)}
        }
    }
}

extension RelpairsListView {
    var details: some View {
        HStack {
            Text("Detail")
                .font(.system(size: 17))
                .font(.system(.title3))
                .foregroundStyle(.secondary)
            
            Image(systemName: "chevron.right")
                .opacity(0.5)
        }
    }
}

#Preview {
    RelpairsListView()
}


