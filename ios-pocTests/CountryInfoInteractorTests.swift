//Created on 12/4/20

import XCTest
@testable import iOS_PoC

class CountryInfoInteractorTests: XCTestCase {
    
    // MARK: - Properties
    
    var countryInfoInteractor: CountryInfoInteractor!
    var dataProvider: MockDataProvider!
    var presenter: MockPresenter!
    
    // MARK: - Lifecycle

    override func setUp() {
        presenter = MockPresenter()
        dataProvider = MockDataProvider()
        countryInfoInteractor = CountryInfoInteractor(withDataProvider: dataProvider)
        countryInfoInteractor.presenter = presenter
    }
    
    func testFetchSuccess() {
        XCTAssertFalse(presenter.success)
        let expectation = self.expectation(description: "Fetch Data")
        countryInfoInteractor.fetchCountryInfo(completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(presenter.success)
    }
    
    func testFetchFail() {
        XCTAssertFalse(presenter.success)
        dataProvider.error = .connection
        countryInfoInteractor = CountryInfoInteractor(withDataProvider: dataProvider)
        let expectation = self.expectation(description: "Fetch Data")
        countryInfoInteractor.fetchCountryInfo(completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(presenter.success)
    }
}
