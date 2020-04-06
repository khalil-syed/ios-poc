//Created on 7/4/20

import Foundation

struct CountryInfoItem: Decodable {
    
    // MARK: - Properties
    
    let title: String?
    let description: String?
    let imageHref: String?
}

// MARK: -

extension CountryInfoItem {
    
    static func mock() -> CountryInfoItem {
        CountryInfoItem(title: "Transportation",
                        description: "It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
                        imageHref: "canada")
    }
}
