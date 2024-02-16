//
//  ClientDetailView.swift
//  ReFix
//
//  Created by Ivan Laptii on 16.02.2024.
//

import SwiftUI

struct ClientDetailView: View {
    enum Field: Hashable {
        case brand
        case model
        case serialNumber
        case imei
        case malfunction
        case description
        case client
        case phoneNumber
        case conteragent
        case employee
    }
    
    @EnvironmentObject private var viewModel: ClientDetailViewModel
    @FocusState var isFocused: Field?
    
    var body: some View {
        VStack {
            List {
                customTextField(placeholder: "Ім'я:",text: $viewModel.name)
                customTextField(placeholder: "Фамілія:",text: $viewModel.surname)
                customTextField(placeholder: "Номер телефону:",text: $viewModel.phoneNumber)
                customTextField(placeholder: "Пошта:",text: $viewModel.email)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("\(viewModel.surname) \(viewModel.name)")
        .navigationBarBackButtonHidden(false)
        .toolbar{
            ToolbarItem {
                saveButton
            }
        }
        .onDisappear() {
            viewModel.cleanUp()
        }
    }
}

extension ClientDetailView {
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Text(placeholder)
            TextField("", text: text)
                .modifier(ClearButtonViewModifier(text: text))
        }
        .padding(7)
    }
    
    var saveButton: some View {
        Button("Зберегти"){
            Task {
                try await viewModel.updateRepair()
            }
        }
    }
}

//#Preview {
//    RepairDetailView()
//        .environmentObject(RepairDetailViewModel(repair: Repair.repairsMocked.first!))
//}
