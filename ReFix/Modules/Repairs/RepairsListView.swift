//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {
    
    @StateObject var viewModel = RepairsListViewModel()
    
//    @State private var searchText = ""
//    @State private var searchIsActive = false

    var body: some View {
        
        NavigationStack{
            List(viewModel.searchResults) { item in
                ZStack {
                    HStack {
                        VStack(alignment: .listRowSeparatorLeading, content: {
                            Text("\(item.brand) \(item.model)")
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
                    viewModel.isAddNewRepairPresented = true
                }
                .padding()
                .font(.largeTitle)
                .sheet(isPresented: $viewModel.isAddNewRepairPresented) {
                    AddNewRepairView(futureRepairId: viewModel.futureRepairId)
                        .environmentObject(AddNewRepairViewModel(addNewRepairState: $viewModel.isAddNewRepairPresented, repairListArray: $viewModel.repairListArray))
                        .presentationDetents([.large, .fraction(0.08)], selection: .constant(.large))
                        .presentationBackgroundInteraction(.enabled)
                        .presentationCompactAdaptation(.sheet)
                }
            }
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive, prompt: "Пошук")
            //TODO: Make search suggestions
        }
        .onAppear {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Відмінити"
        }
    }
}

extension RelpairsListView {
    var details: some View {
        HStack {
            Text("Деталі")
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


