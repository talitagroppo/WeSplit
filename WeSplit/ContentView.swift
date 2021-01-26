//
//  ContentView.swift
//  WeSplit
//
//  Created by Talita Groppo on 18/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 0
    
    let tipPercentages = [10, 14, 20, 25, 0]
    
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerson = grandTotal / peopleCount
        
        return amountPerson
    }
    
    var total: Double {
        return totalPerson * (Double(numberOfPeople) ?? 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number os people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                                .tag(self.tipPercentages[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:Text("Amount per person")){
                    Text("$\(totalPerson, specifier: "%.2f")")
                }
                
                Section(header:Text("Total amount")) {
                    Text("$\(total, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



