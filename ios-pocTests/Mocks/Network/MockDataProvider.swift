//Created on 7/4/20

import Foundation
@testable import iOS_PoC

struct MockDataProvider: DataProvider {
    
    func fetchCountryInfo(completion: @escaping ((CountryInfo?, APIError?) -> Void)) {
        completion(CountryInfo.mock(), nil)
    }
}
