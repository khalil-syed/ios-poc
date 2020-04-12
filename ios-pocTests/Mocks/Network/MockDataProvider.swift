//Created on 7/4/20

import Foundation
@testable import iOS_PoC

struct MockDataProvider: DataProvider {
    
    var error: APIError?
    
    func fetchCountryInfo(completion: @escaping ((CountryInfoModel?, APIError?) -> Void)) {
        if let error = error {
            completion(nil, error)
            return
        }
        completion(CountryInfoModel.mock(), nil)
    }
}
