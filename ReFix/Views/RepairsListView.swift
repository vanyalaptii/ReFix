//
//  RelpairsListView.swift
//  ReFix
//
//  Created by Ivan Laptii on 23.12.2023.
//

import SwiftUI

struct RelpairsListView: View {

    @State var repairsArray = Repair.repairsMocked

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


