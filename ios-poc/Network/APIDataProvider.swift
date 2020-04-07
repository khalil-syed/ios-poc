//Created on 7/4/20

import Foundation
import Network

struct APIDataProvider: DataProvider {
    
    // MARK: - Properties
    
    let session: URLSession
    
    // MARK: - Initializer
    
    init(withSession session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Methods
    
    func fetchCountryInfo(completion: @escaping ((CountryInfo?, APIError?) -> Void)) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil, .invalidURL)
            return
        }
        
        let dataTask = session.dataTask(with: url,
                                        completionHandler: { data, response, error in
            
            if let error = error {
                print(error)
                completion(nil, self.apiError(error))
                return
            }
            
            guard let data = self.sanitiseData(data) else {
                completion(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countryInfo = try decoder.decode(CountryInfo.self, from: data)
                completion(countryInfo, nil)
                
            } catch let parsingError {
                print(parsingError)
                completion(nil, .parsing(description: parsingError.localizedDescription))
            }
        })
        
        dataTask.resume()
    }
    
    // MARK: - Private Methods
    
    private func apiError(_ error: Error) -> APIError {
        if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
            return .connection
        }
        
        return .apiError(description: error.localizedDescription)
    }
    
    private func sanitiseData(_ data: Data?) -> Data? {
        guard let data = data,
            let string = String(data: data, encoding: String.Encoding.isoLatin1),
            let dataUtf8 = string.data(using: .utf8, allowLossyConversion: true)
            else { return nil}
        
        return dataUtf8
    }
}
