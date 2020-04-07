//Created on 7/4/20

import XCTest
@testable import iOS_PoC

class MainViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    
    var mainViewController: MockMainViewController!
    
    // MARK: - Lifecycle

    override func setUp() {
        mainViewController = MockMainViewController(withDataProvider: MockDataProvider())
    }
    
    func testViewDidLoad() {
        mainViewController.viewDidLoad()
        XCTAssertTrue(mainViewController.tableViewSetup)
        XCTAssertTrue(mainViewController.refreshControlSetup)
        XCTAssertTrue(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.viewDidLoadCompleted)
    }
    
    func testFetchDataSuccess() {
        XCTAssertFalse(mainViewController.dataFetchSuccessCalled)
        XCTAssertFalse(mainViewController.dataFetchErrorCalled)
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 0)
        
        let expectation = self.expectation(description: "Fetch Data")
        mainViewController.fetchData(completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mainViewController.dataFetchSuccessCalled)
        XCTAssertFalse(mainViewController.dataFetchErrorCalled)
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertFalse(mainViewController.title?.isEmpty ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 2)
        XCTAssertFalse(mainViewController.refreshControl?.isRefreshing ?? true)
    }
    
    func testRefresh() {
        mainViewController.refresh(sender: self)
        XCTAssertTrue(mainViewController.fetchingData)
    }
    
    func testFetchDataFailure() {
        var mockDataProvider = MockDataProvider()
        mockDataProvider.error = .connection
        mainViewController = MockMainViewController(withDataProvider: mockDataProvider)
        
        XCTAssertFalse(mainViewController.dataFetchSuccessCalled)
        XCTAssertFalse(mainViewController.dataFetchErrorCalled)
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 0)
        
        let expectation = self.expectation(description: "Fetch Data")
        mainViewController.fetchData(completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(mainViewController.dataFetchSuccessCalled)
        XCTAssertTrue(mainViewController.dataFetchErrorCalled)
        XCTAssertFalse(mainViewController.fetchingData)
        XCTAssertTrue(mainViewController.title?.isEmpty ?? true)
        XCTAssertTrue(mainViewController.tableView?.numberOfRows(inSection: 0) == 0)
        XCTAssertFalse(mainViewController.refreshControl?.isRefreshing ?? true)
    }
}
