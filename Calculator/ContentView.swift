//
//  ContentView.swift
//  Calculator
//
//  Created by Sho Tamaki on 2023/10/09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    let buttons: [[String]] = [
        ["AC", "delete.backward.fill", "+/-", "%"],
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "-"],
        ["0", ".", "=", "+"]
    ]
    let buttonSize: CGFloat = (UIScreen.main.bounds.width - 50) / 4
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            displayView()
            Spacer()
            ForEach(buttons, id:\.self) { items in
                HStack{
                    ForEach(items, id:\.self) { item in
                        buttonView(item: item)
                    }
                }
            }
            .frame(height: buttonSize)
            Spacer()
        }
        .padding()
    }
    
    private func displayView() -> some View {
        HStack {
            //Spacer()
            Text(vm.displayedNumber)
                .accessibility(identifier: "DisplayedNumber")
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color("BackgroundColor"))
                .cornerRadius(25)
                .font(.system(size: 60))
                .foregroundColor(Color("TextColor"))
                .lineLimit(1)
                .minimumScaleFactor(0.3)
        }
    }
    
    private func buttonView(item: String) -> some View {
        Button {
            vm.handleButton(item: item)
        } label: {
            if item == "delete.backward.fill" {
                Text(Image(systemName: "delete.backward.fill"))
                    .frame(width: buttonSize, height: buttonSize)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(25)
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(Color("TextColor"))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else {
                Text(item)
                    .frame(width: buttonSize, height: buttonSize)
                    .background((item == vm.checkedOperator) ? .yellow : Color("BackgroundColor"))
                    .cornerRadius(25)
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(Color("TextColor"))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
