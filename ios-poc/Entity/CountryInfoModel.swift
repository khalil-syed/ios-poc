//Created on 7/4/20

import Foundation

struct CountryInfoModel: Decodable {
    
    // MARK: - Properties
    
    let title: String?
    private let rows: [CountryInfoItem]?
    
    // MARK: - Methods
    
    func countryItems() -> [CountryInfoItem] {
        (rows ?? []).filter { $0.hasData() }
    }
}

// MARK: - Mock

extension CountryInfoModel {
    
    static func mock() -> CountryInfoModel {
        CountryInfoModel(title: "About Canada",
                    rows: [CountryInfoItem.mock(), CountryInfoItem.mock()])
    }
}
