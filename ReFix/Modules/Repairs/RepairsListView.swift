//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {
    
    @ObservedObject private var viewModel = RepairsListViewModel()
    
//    @State private var searchText = ""
//    @State private var searchIsActive = false
    
    var body: some View {
        NavigationView {
            List($viewModel.repairListArray.sorted{$0.id > $1.id}) { $item in
                listRepairRow(repair: $item)
//    @State private var searchText = ""
//    @State private var searchIsActive = false
//
//    var body: some View {
//        
//        NavigationStack{
//            List(viewModel.searchResults) { item in
//                ZStack {
//                    HStack {
//                        VStack(alignment: .listRowSeparatorLeading, content: {
//                            Text("\(item.brand) \(item.model)")
//                                .font(.system(size: 17))
//                                .padding(1)
//                            Text("#\(item.id)")
//                                .font(.system(size: 15))
//                                .foregroundStyle(.secondary)
//                        })
//                        
//                        Spacer()
//                        
//                        details
//                    }
//                    .padding(.horizontal)
//                    
//                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
//                }
//                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Ремонти")
//            .searchable(text: $searchText, isPresented: $searchIsActive, prompt: "Пошук")
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive, prompt: "Пошук")
            //TODO: Make search suggestions
            .toolbar {
                addButton
            }
        }
        .onAppear {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Відмінити"
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
        
//        Button("+") {
//            viewModel.addNewRepairIsPresented = true
//        }
//        .padding()
//        .font(.largeTitle)
//        .sheet(isPresented: $viewModel.addNewRepairIsPresented) {
//            AddNewRepairView(futureRepairId: viewModel.futureRepairId)
//                .environmentObject(viewModel)
//                .presentationDetents([.large, .fraction(0.08)], selection: .constant(.large))
//                .presentationBackgroundInteraction(.enabled)
//                .presentationCompactAdaptation(.sheet)
//        }
    }
}

#Preview {
    RelpairsListView()
}


