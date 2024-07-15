//
//  ContentView.swift
//  JPCountryPicker
//
//  Created by Jaykar Parmar on 11/07/24.
//

import SwiftUI
import Combine

/// The main view of the JPCountryPicker app, displaying the selected country's details and allowing the user to change the country.
struct ContentView: View {
    
    /// The list of countries loaded from a JSON file.
    @State private var countries: [Country] = loadJSON(filename: "Countries")
    /// The currently selected country.
    @State private var selectedCountry: Country?
    /// A Boolean state that determines whether the country list view is presented.
    @State var isCountryDisplayed = false
    
    @State private var phoneNumber = ""
    
    var body: some View {
        VStack(spacing: 8) {
            Text("JPPhoneNumberFormatter")
                .font(.title2.bold())
            
            HStack {
                Button(action: {
                    UIApplication.shared.endEditing()
                    self.isCountryDisplayed = true
                }, label: {
                    HStack {
                        Text(self.selectedCountry?.flag ?? "")
                        Text(self.selectedCountry?.dialCode ?? "")
                    }
                })
                
                TextField("Phone Number", text: self.$phoneNumber)
                    .keyboardType(.numberPad)
                    .onChange(of: self.phoneNumber) { newValue in
                        self.phoneNumber = formatPhoneNumber()
                    }
                    .onChange(of: self.selectedCountry) { newValue in
                        self.phoneNumber = formatPhoneNumber()
                    }
            }
            .padding(.top, 30)
            .foregroundStyle(.black)
            Rectangle()
                .foregroundStyle(.blue)
                .frame(height: 1)
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isCountryDisplayed, content: {
            CountryListView(countries: self.countries, selectedCountry: $selectedCountry, isCountryDisplayed: $isCountryDisplayed)
        })
        
        .onAppear(perform: {
            self.setupView()
        })
    }
}

extension ContentView {
    /// Sets up the view by initializing the selected country.
    func setupView() {
        self.selectedCountry = currentCountry(countries: self.countries)
    }
    
    private func formatPhoneNumber() -> String {
        let cleanedPhoneNumber = phoneNumber.filter { "0123456789".contains($0) }
//        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = self.selectedCountry?.phoneFormat ?? ""
        var result = ""
        var index = cleanedPhoneNumber.startIndex
        
        for ch in mask where index < cleanedPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanedPhoneNumber[index])
                index = cleanedPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

#Preview {
    ContentView()
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
