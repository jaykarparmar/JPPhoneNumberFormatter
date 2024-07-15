//
//  CountryListView.swift
//  JPCountryPicker
//
//  Created by Jaykar Parmar on 11/07/24.
//

import SwiftUI

/// A view that displays a list of countries and allows the user to search and select a country.
struct CountryListView: View {
    
    /// The list of countries to display.
    var countries: [Country] = []
    /// The currently selected country, bound to the parent view.
    @Binding var selectedCountry: Country?
    /// The search text entered by the user.
    @State private var searchText = ""
    /// A Boolean state that determines whether the country list view is displayed, bound to the parent view.
    @Binding var isCountryDisplayed: Bool
    
    /// The filtered list of countries based on the search text.
    var searchResults: [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return self.countries.filter({ ($0.name ?? "").contains(searchText) })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List(self.searchResults, id: \.self) { country in
                    CountryItemView(country: country, isShowCheckmark: country == selectedCountry, actionSelectedCountry: {
                        self.selectedCountry = country
                        self.isCountryDisplayed = false
                    })
                }
                .searchable(text: $searchText)
                .listStyle(.plain)
            }
            .navigationTitle("Select Your Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.isCountryDisplayed = false
                    }
                }
            }
        }
    }
}

#Preview {
    CountryListView(selectedCountry: .constant(Country()), isCountryDisplayed: .constant(true))
}
