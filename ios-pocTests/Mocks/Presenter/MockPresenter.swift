//Created on 11/4/20

import Foundation
@testable import iOS_PoC

class MockPresenter: InteractorToPresenterProtocol, ViewToPresenterProtocol {
    
    // MARK: - Properties
    
    var success: Bool = false
    
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    var error: APIError?
    
    // MARK: - Methods
    
    func countryInfoFetchSuccess(countryInfoModel: CountryInfoModel) {
        success = true
        view?.showCountryInfo(countryInfoModel)
    }
    
    func countryInfoFetchFailed(withError error: APIError) {
        success = false
        view?.showError(error)
    }
    
    func updateView() {
        if let error = error {
            countryInfoFetchFailed(withError: error)
            return
        }
        
        countryInfoFetchSuccess(countryInfoModel: CountryInfoModel.mock())
    }
}
