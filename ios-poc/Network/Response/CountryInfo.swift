//Created on 7/4/20

import Foundation

struct CountryInfo: Decodable {
    
    // MARK: - Properties
    
    let title: String?
    private let rows: [CountryInfoItem]?
    
    // MARK: - Methods
    
    func countryItems() -> [CountryInfoItem] {
        (rows ?? []).filter { $0.hasData() }
    }
}
