//Created on 7/4/20

import XCTest
@testable import iOS_PoC

class CountryInfoViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    
    var mainViewController: MockCountryInfoViewController!
    var presenter: MockPresenter!
    
    // MARK: - Lifecycle

    override func setUp() {
        mainViewController = MockCountryInfoViewController()
        presenter = MockPresenter()
        presenter.view = mainViewController
        mainViewController.presenter = presenter
    }
    
    func testViewDidLoad() {
        mainViewController.viewDidLoad()
        XCTAssertTrue(mainViewController.tableViewSetup)
        XCTAssertTrue(mainViewController.refreshControlSetup)
        XCTAssertTrue(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.viewDidLoadCompleted)
    }
    
    func testFetchDataSuccess() {
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        
        mainViewController.viewDidLoad()
        
        XCTAssertFalse(mainViewController.title?.isEmpty ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 2)
        XCTAssertFalse(mainViewController.refreshControl?.isRefreshing ?? true)
    }
    
    func testRefresh() {
        mainViewController.refresh(sender: self)
        XCTAssertTrue(mainViewController.fetchingData)
    }
    
    func testFetchDataFailure() {
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        presenter.error = .connection
        mainViewController.presenter = presenter
        mainViewController.viewDidLoad()
        
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        XCTAssertFalse(mainViewController.refreshControl?.isRefreshing ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 0)
    }
}
