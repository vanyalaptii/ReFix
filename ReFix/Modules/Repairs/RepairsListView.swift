//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RepairsListView: View {
    @ObservedObject private var viewModel = RepairsListViewModel()
    
    var body: some View {
        NavigationView {
            List($viewModel.searchResults) { $item in
                listRepairRow(repair: $item)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("Ремонти")
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive, prompt: "Пошук")
            //TODO: Make search suggestions
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
        }
        .onAppear {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Відмінити"
        }
    }
}

extension RelpairsListView {
    private func listRepairRow(repair: Binding<Repair>) -> some View {
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
}

#Preview {
    RepairsListView()
}
