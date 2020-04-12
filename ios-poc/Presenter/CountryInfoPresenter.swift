//Created on 10/4/20

import Foundation

protocol ViewToPresenterProtocol: class {
    
    // MARK: - Properties
    
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresentorToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    
    // MARK: - Methods
    
    func updateView()
}

// MARK -

protocol InteractorToPresenterProtocol: class {
    
    // MARK: - Methods
    
    func countryInfoFetchSuccess(countryInfoModel: CountryInfoModel)
    func countryInfoFetchFailed(withError error: APIError)
}

// MARK: -

class CountryInfoPresenter: ViewToPresenterProtocol {
    
    // MARK: - Properties
    
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    // MARK: - Methods
    
    func updateView() {
        interactor?.fetchCountryInfo(completion: nil)
    }
}

// MARK: -

extension CountryInfoPresenter: InteractorToPresenterProtocol {
    
    // MARK: - Methods
    
    func countryInfoFetchSuccess(countryInfoModel: CountryInfoModel) {
        view?.showCountryInfo(countryInfoModel)
    }
    
    func countryInfoFetchFailed(withError error: APIError) {
        view?.showError(error)
    }
}
