//
//  ClientsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct ClientsListView: View {
    
    @ObservedObject private var viewModel = ClientsListViewModel()
    
    var body: some View {
        NavigationView {
            List($viewModel.searchResults) { $item in
                listClientRow(client: $item)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Клієнти")
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

extension ClientsListView {
    
    func listClientRow(client: Binding<Client>) -> some View {
        HStack {
            Text("\(client.wrappedValue.surname) \(client.wrappedValue.name)")
            NavigationLink(destination: {
                ClientDetailView()
                    .environmentObject(ClientDetailViewModel(client: client))
            }, label: {})
            .frame(maxWidth: 30)
            .opacity(.zero)
        }
    }
    
    var addButton: some View {
        Button("+") {
            viewModel.isAddNewClientPresented = true
        }
        .padding()
        .font(.largeTitle)
        .sheet(isPresented: $viewModel.isAddNewClientPresented) {
            AddNewClientView(futureClientId: viewModel.futureClientId)
                .environmentObject(AddNewClientViewModel(addNewClientState: $viewModel.isAddNewClientPresented, clientListArray: $viewModel.clientsListArray))
                .presentationDetents([.large, .fraction(0.08)], selection: .constant(.large))
                .presentationBackgroundInteraction(.enabled)
                .presentationCompactAdaptation(.sheet)
        }
    }
}

#Preview {
    ClientsListView()
}
