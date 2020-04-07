//Created on 7/4/20

import Foundation
@testable import iOS_PoC

class MockMainViewController: MainViewController {
    
    // MARK: - Properties
    
    var viewDidLoadCompleted = false
    var tableViewSetup = false
    var refreshControlSetup = false
    var fetchingData = false
    var dataFetchSuccessCalled = false
    var dataFetchErrorCalled = false
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCompleted = true
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableViewSetup = true
    }
    
    override func setupRefreshControl() {
        super.setupRefreshControl()
        refreshControlSetup = true
    }
    
    override func fetchData(completion: (() -> Void)? = nil) {
        fetchingData = true
        dataFetchErrorCalled = false
        dataFetchSuccessCalled = false
        super.fetchData(completion: completion)
    }
    
    override func onSuccess(response: CountryInfo) {
        super.onSuccess(response: response)
        dataFetchSuccessCalled = true
        fetchingData = false
    }
    
    override func onError(_ error: APIError) {
        super.onError(error)
        dataFetchErrorCalled = true
        fetchingData = false
    }
    
    override func refresh(sender: AnyObject) {
        super.refresh(sender: sender)
        fetchingData = true
    }
}
