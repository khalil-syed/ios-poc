//Created on 10/4/20

import Foundation

protocol PresentorToInteractorProtocol: class {
    
    // MARK: - Properties
    
    var presenter: InteractorToPresenterProtocol? { get set }
    
    // MARK: - Methods
    
    func fetchCountryInfo(completion: (() -> Void)?)
}

// MARK: -

class CountryInfoInteractor: PresentorToInteractorProtocol {
    
    // MARK: - Properties
    
    var presenter: InteractorToPresenterProtocol?
    private let dataProvider: DataProvider?
    
    // MARK: - Initializer
    
    init(withDataProvider dataProvider: DataProvider = APIDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Methods
    
    func fetchCountryInfo(completion: (() -> Void)? = nil) {
        dataProvider?.fetchCountryInfo(completion: { [weak self] response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.presenter?.countryInfoFetchFailed(withError: error)
                    completion?()
                    return
                }
                guard let response = response else { return }
                self?.presenter?.countryInfoFetchSuccess(countryInfoModel: response)
                completion?()
            }
        })
    }
}
