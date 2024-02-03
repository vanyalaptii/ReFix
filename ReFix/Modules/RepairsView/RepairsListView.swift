//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {
    
    @ObservedObject private var viewModel = RepairsListViewModel()
    
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var body: some View {
        NavigationView {
            List($viewModel.repairListArray.sorted{$0.id > $1.id}) { $item in
                listRepairRow(repair: $item)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Ремонти")
            .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "Пошук")
            //TODO: Make search suggestions
            .toolbar {
                addButton
            }
        }
        .onAppear {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Відмінити"
        }
    }
    
    var searchResults: [Repair] {
        if searchText.isEmpty {
            return viewModel.repairListArray.sorted { $0.id > $1.id }
        } else {
            return viewModel.repairListArray
                .filter { $0.model.contains(searchText) }
                .sorted { $0.id > $1.id }
            + viewModel.repairListArray
                .filter { $0.brand.contains(searchText) }
                .sorted { $0.id > $1.id }
            + viewModel.repairListArray
                .filter { $0.id.description.contains(searchText) }
                .sorted { $0.id > $1.id }
            + viewModel.repairListArray
                .filter { $0.imei.description.contains(searchText) }
                .sorted { $0.id > $1.id }
            + viewModel.repairListArray
                .filter { $0.serialNumber.description.contains(searchText) }
                .sorted { $0.id > $1.id }
            //                 + repairsArray.filter { $0.client.name.contains(searchText) }
            //                 + repairsArray.filter { $0.client.phoneNumber.contains(searchText)}
        }
    }
}

extension RelpairsListView {
    
    func listRepairRow(repair: Binding<Repair>) -> some View {
        ZStack {
            HStack {
                VStack(alignment: .listRowSeparatorLeading, content: {
                    Text("\(repair.wrappedValue.brand) \(repair.wrappedValue.model)")
                        .font(.system(size: 17))
                        .padding(1)
                    Text("#\(repair.id)")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                })
                Spacer()
                NavigationLink(destination: {
                    RepairDetailView()
                        .environmentObject(RepairDetailViewModel(repair: repair))
                }, label: {})
                .frame(maxWidth: 30)
            }
            .padding(.horizontal)
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
        }
        .listRowSeparator(.hidden)
    }
    
    var addButton: some View {
        Button("+") {
            viewModel.addNewRepairIsPresented = true
        }
        .padding()
        .font(.largeTitle)
        .sheet(isPresented: $viewModel.addNewRepairIsPresented) {
            AddNewRepairView(futureRepairId: viewModel.futureRepairId)
                .environmentObject(viewModel)
                .presentationDetents([.large, .fraction(0.08)], selection: .constant(.large))
                .presentationBackgroundInteraction(.enabled)
                .presentationCompactAdaptation(.sheet)
        }
    }
}

#Preview {
    RelpairsListView()
}


