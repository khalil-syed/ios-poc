//Created on 10/4/20

import Foundation
import UIKit

protocol PresenterToRouterProtocol: class {
    
    // MARK: - Methods
    
    static func createModule() -> UIViewController
}


class CountryInfoRouter: PresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let viewController = CountryInfoViewController()
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = CountryInfoPresenter()
        let interactor: PresentorToInteractorProtocol = CountryInfoInteractor()
        let router: PresenterToRouterProtocol = CountryInfoRouter()


        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return viewController
    }
}
