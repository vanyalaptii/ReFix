//
//  AddNewRepairView.swift
//  ReFix
//
//  Created by Ivan Laptii on 26.01.2024.
//

import SwiftUI

struct AddNewRepairView: View {
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
    
    @EnvironmentObject private var viewModel: AddNewRepairViewModel
    @FocusState var isFocused: Field?
    var futureRepairId: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    newRepairTextFieldForm()
                    saveNewRepairButton()
                }
                .background(Color(.secondarySystemBackground))
                .navigationTitle("Новий ремонт")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.addNewRepairIsPresented = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.secondary)
                            .opacity(0.7)
                    }
                    .padding(10)
                }
            }
        }
    }
}

extension AddNewRepairView {
    func newRepairTextFieldForm() -> some View {
        VStack {
            Form{
                Section("# \(futureRepairId)"){
                    customTextFieldWithText(placeholder: "Марка", text: $viewModel.brand)
                        .focused($isFocused, equals: .brand)
                    customTextFieldWithText(placeholder: "Модель", text: $viewModel.model)
                        .focused($isFocused, equals: .model)
                    customTextFieldWithText(placeholder: "S/N", text: $viewModel.serialNumber)
                        .focused($isFocused, equals: .serialNumber)
                    customTextFieldWithText(placeholder: "IMEI", text: $viewModel.imei)
                        .focused($isFocused, equals: .imei)
                    customTextFieldWithText(placeholder: "Несправність", text: $viewModel.malfunction)
                        .focused($isFocused, equals: .malfunction)
                    customTextFieldWithText(placeholder: "Опис", text: $viewModel.description)
                        .focused($isFocused, equals: .description)
                    customTextFieldWithText(placeholder: "Здав", text: $viewModel.client)
                        .focused($isFocused, equals: .client)
                    customTextFieldWithText(placeholder: "Номер телефону", text: $viewModel.phoneNumber)
                        .focused($isFocused, equals: .phoneNumber)
                    customTextFieldWithText(placeholder: "Майстер", text: $viewModel.conteragent)
                        .focused($isFocused, equals: .conteragent)
                    customTextFieldWithText(placeholder: "Прийняв", text: $viewModel.employee)
                        .focused($isFocused, equals: .employee)
                    HStack{
                        Spacer()
                        Button("Очистити") {
                            viewModel.cleanFields()
                        }
                        Spacer()
                    }
                }
            }
            .frame(minHeight: 525)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .scrollDisabled(true)
        }
    }
    
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .modifier(ClearButtonViewModifier(text: text))
    }
    
    func customTextFieldWithText(placeholder: String, text: Binding<String>) -> some View {
        HStack(alignment: .center) {
            Text(placeholder)
            customTextField(placeholder: "", text: text)
        }
    }
    
    func saveNewRepairButton() -> some View {
        Button("Додати"){
            Task {
                await viewModel.addNewRepair()
            }
        }
        .padding(50)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AddNewRepairView(futureRepairId: 1)
        .environmentObject(RepairsListViewModel())
}
