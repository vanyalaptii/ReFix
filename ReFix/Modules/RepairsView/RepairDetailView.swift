//
//  RepairDetailView.swift
//  ReFix
//
//  Created by Ivan Laptii on 31.01.2024.
//

import SwiftUI

struct RepairDetailView: View {
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
    
    @EnvironmentObject private var viewModel: RepairDetailViewModel
    @FocusState var isFocused: Field?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    customTextField(placeholder: "Марка",text: $viewModel.brand)
                    customTextField(placeholder: "Модель",text: $viewModel.model)
                    customTextField(placeholder: "S/N",text: $viewModel.serialNumber)
                    customTextField(placeholder: "IMEI",text: $viewModel.imei)
                    customTextField(placeholder: "Несправність",text: $viewModel.malfunction)
                    customTextField(placeholder: "Опис",text: $viewModel.description)
                    customTextField(placeholder: "Здав",text: $viewModel.client)
                    customTextField(placeholder: "Прийняв",text: $viewModel.employee)
                    customTextField(placeholder: "Статус",text: $viewModel.repairStatus)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Ремонт #\(viewModel.id)")
        .navigationBarBackButtonHidden(false)
        .onDisappear() {
            Task {
                try await viewModel.updateRepair()
            }
        }
    }
}

extension RepairDetailView {
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        HStack {
            Text(placeholder)
            TextField("", text: text)
                .modifier(ClearButtonViewModifier(text: text))
        }
        .padding(7)
    }
}

#Preview {
    RepairDetailView()
        .environmentObject(RepairDetailViewModel(repair: Repair.repairsMocked.first!))
}
