//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ваня Лаптий on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {
    
    @State var repairsArray = ResourceLoader.shared.loadAlarmList()
    
    var body: some View {
        List(repairsArray) { item in
            HStack {
                VStack(alignment: .listRowSeparatorLeading, content: {
                    Text(item.model)
                        .font(.system(size: 17))
                        .padding(1)
                    Text("#\(item.id)")
                        .font(.system(size: 15))
                })
                Spacer()
                HStack {
                    Text("Detail")
                        .font(.system(size: 17))
                        .font(.system(.title3))
                        .foregroundStyle(.secondary)
                    Image(systemName: "chevron.right")
                }
            }
            .padding(1)
        }
    }
}

#Preview {
    RelpairsListView()
}

struct ResourceLoader {
  static private(set) var shared = ResourceLoader()
  
  func loadAlarmList() -> [RepairCase]{
      return [
        RepairCase(
            id: 1,
            brand: "Apple",
            model: "iPhone 13",
            serialNumber: "MK35HF754",
            imei: 432143214321123,
            malfunction: "Швидко розряджається",
            description: "Подряпини єкрану",
            client: "Микола Іванович",
            telephone: "0976354213",
            employee: "Світлана",
            repairStatus: "Узгодження"),
        
        RepairCase(
            id: 2,
            brand: "Apple",
            model: "MacBook Pro 13",
            serialNumber: "MK354SYR4",
            imei: nil,
            malfunction: "Розбитий екран",
            description: "Потертості",
            client: "Іван Федорович",
            telephone: "0686754387",
            employee: "Олена",
            repairStatus: "Виконано")
    ]
  }
}
