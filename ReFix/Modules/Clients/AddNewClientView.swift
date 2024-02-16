//
//  AddNewClientView.swift
//  ReFix
//
//  Created by Ivan Laptii on 13.02.2024.
//

import SwiftUI

struct AddNewClientView: View {
    enum Field: Hashable {
        case name
        case surname
        case phoneNumber
        case email
    }
    
    @EnvironmentObject private var viewModel: AddNewClientViewModel
    @FocusState var isFocused: Field?
    var futureClientId: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    newClientTextFieldForm()
                    saveNewClientButton()
                }
                .background(Color(.secondarySystemBackground))
                .navigationTitle("Новий клієнт")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.isAddNewClientPresented = false
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

extension AddNewClientView {
    func newClientTextFieldForm() -> some View {
        VStack {
            Form{
                customTextFieldWithText(placeholder: "Ім'я", text: $viewModel.name)
                    .focused($isFocused, equals: .name)
                customTextFieldWithText(placeholder: "Фамілія", text: $viewModel.surname)
                    .focused($isFocused, equals: .surname)
                customTextFieldWithText(placeholder: "Номер телефону", text: $viewModel.phoneNumber)
                    .focused($isFocused, equals: .phoneNumber)
                customTextFieldWithText(placeholder: "Пошта", text: $viewModel.email)
                    .focused($isFocused, equals: .email)
                HStack{
                    Spacer()
                    Button("Очистити") {
                        viewModel.cleanFields()
                    }
                    Spacer()
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
    
    func saveNewClientButton() -> some View {
        Button("Додати"){
            Task {
                await viewModel.addNewClient()
            }
        }
        .padding(50)
        .buttonStyle(.borderedProminent)
    }
}

//#Preview {
//    AddNewClientView(futureClientId: 1)
//}
