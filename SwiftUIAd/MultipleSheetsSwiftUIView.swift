//
//  MultipleSheetsSwiftUIView.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-23.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// THREE WAYS TO GET THE MULTIPLE SCREEN
/*
 1. use a binding
 2. use multiple .sheet
 3. use $item
 */

struct MultipleSheetsSwiftUIView: View {

    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "1")
                showSheet.toggle()
            }

            Button("Button 2") {
                selectedModel = RandomModel(title: "2")
                showSheet.toggle()
            }
        }
        // AVOID ANY CONTIONAL HERE, IT WONT WORK
        .sheet(isPresented: $showSheet, content: {
            NextScreen(selectedModel: selectedModel)
        })
    }
}

struct NextScreen: View {

    // METHOD1: Binding
//    @Binding var selectedModel: RandomModel
    let selectedModel: RandomModel


    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


#Preview {
    MultipleSheetsSwiftUIView()
}
