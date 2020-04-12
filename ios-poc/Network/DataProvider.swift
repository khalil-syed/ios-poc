//Created on 7/4/20

import Foundation
import Combine

protocol DataProvider {
    
    func fetchCountryInfo(completion: @escaping ((CountryInfoModel?, APIError?) -> Void))
}
