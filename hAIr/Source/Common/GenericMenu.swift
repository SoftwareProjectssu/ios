//
//  PopUpTable.swift
//  hAIr
//
//  Created by 한태빈 on 5/28/25.
//
import SwiftUI

struct GenericMenu<Label: View>: View {
  let items: [MenuItem]
  let label: () -> Label

  var body: some View {
    Menu {
      ForEach(items) { item in
        Button(item.title, role: item.role) {
          item.action()
        }
      }
    } label: {
      label()
    }
  }
}
