//Created on 7/4/20

import Foundation
import UIKit
@testable import iOS_PoC

class MockCustomTableViewCell: CustomTableViewCell {
    
    // MARK: - Properties
    
    var subviewsAdded = false
    var constraintsAdded = false
    var loadImageCalled = false
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    
    override func addSubviews() {
        super.addSubviews()
        subviewsAdded = true
    }
    
    override func setAutoLayoutConstraints() {
        super.setAutoLayoutConstraints()
        constraintsAdded = true
    }
    
    override func loadImage(url: String?, callback: (() -> Void)?) {
        super.loadImage(url: url, callback: callback)
        loadImageCalled = true
    }
}
