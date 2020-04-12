//Created on 7/4/20

import Foundation
@testable import iOS_PoC

class MockCountryInfoViewController: CountryInfoViewController {
    
    // MARK: - Properties
    
    var viewDidLoadCompleted = false
    var tableViewSetup = false
    var refreshControlSetup = false
    var fetchingData = false
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCompleted = true
        fetchingData = true
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableViewSetup = true
    }
    
    override func setupRefreshControl() {
        super.setupRefreshControl()
        refreshControlSetup = true
    }
    
    override func refresh(sender: AnyObject) {
        super.refresh(sender: sender)
        fetchingData = true
    }
    
    override func showCountryInfo(_ countryInfoModel: CountryInfoModel) {
        super.showCountryInfo(countryInfoModel)
        fetchingData = false
    }
    
    override func showError(_ error: APIError) {
        super.showError(error)
        fetchingData = false
    } 
}
