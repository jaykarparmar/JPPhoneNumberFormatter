//
//  CountryItemView.swift
//  JPCountryPicker
//
//  Created by Jaykar Parmar on 11/07/24.
//

import SwiftUI

/// A view that displays information about a country and allows the user to select it.
struct CountryItemView: View {
    
    /// The country to display.
    var country: Country?
    /// A Boolean value indicating whether to show a checkmark.
    var isShowCheckmark = false
    /// An action to perform when the country is selected.
    var actionSelectedCountry: () -> ()
    
    var body: some View {
        Button {
            self.actionSelectedCountry()
        } label: {
            HStack(spacing: 8) {
                Text(country?.flag ?? "")
                Text(country?.name ?? "")
                
                Spacer()
                
                if isShowCheckmark {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
                
                Text(country?.dialCode ?? "")
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    CountryItemView(country: Country(name: "India", dialCode: "+91", code: "IN", flag: "\u{1F1EE}\u{1F1F3}", phoneFormat: "###-###-####", phoneNumberDigit: 10), actionSelectedCountry: {})
}


