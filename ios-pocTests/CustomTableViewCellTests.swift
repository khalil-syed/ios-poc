//Created on 7/4/20

import Foundation
import XCTest
@testable import iOS_PoC

class CustomTableViewCellTests: XCTestCase {
    
    // MARK: - Properties
    
    var customTableViewCell: MockCustomTableViewCell!
    
    // MARK: - Lifecycle

    override func setUp() {
        customTableViewCell = MockCustomTableViewCell(style: .default,
                                                      reuseIdentifier: "CustomTableViewCell")
    }
    
    func testInit() {
        XCTAssertTrue(customTableViewCell.subviewsAdded)
        XCTAssertTrue(customTableViewCell.constraintsAdded)
    }
    
    func testDataDidSet() {
        XCTAssertFalse(customTableViewCell.loadImageCalled)
        XCTAssertTrue(customTableViewCell.lblTitle.text?.isEmpty ?? true)
        XCTAssertTrue(customTableViewCell.lblDescription.text?.isEmpty ?? true)
        
        customTableViewCell.countryInfoItem = CountryInfoItem.mock()
        XCTAssertTrue(customTableViewCell.loadImageCalled)
        XCTAssertFalse(customTableViewCell.lblTitle.text?.isEmpty ?? true)
        XCTAssertFalse(customTableViewCell.lblDescription.text?.isEmpty ?? true)
    }
    
    func testLoadImageSuccess() {
        let expectation = self.expectation(description: "Load Image")
        customTableViewCell.loadImage(url: "https://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png", callback: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
}
