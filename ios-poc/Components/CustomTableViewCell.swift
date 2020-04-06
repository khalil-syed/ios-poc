//Created on 7/4/20

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - SubViews
    
    private lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(named: "canada")
        return img
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.text = "Transportation"
        label.textAlignment = .center
        return label
    }()

    private lazy var lblDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textColor = .darkText
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.text = "It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal."
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setAutoLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods

    private func addSubviews() {
        contentView.addSubview(imgView)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescription)
    }
    
    // MARK: Constraints
    
    private func setAutoLayoutConstraints() {
        
        let margins = contentView.layoutMarginsGuide
        var constraints = [
            // Anchor image view to top of content view margins
            imgView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            // Anchor image view to Horizontal center of the cell
            imgView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            // Anchor title label to bottom of image view with some spacing
            lblTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20),
            // Anchor description label to bottom of title label with some spacing
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10),
            // Anchor description label to bottom of content view. This allows dynamic sizing of cells
            lblDescription.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0)
        ]
        
        // Stretch both labels to cover the width of the cell
        constraints.append(contentsOf: constraintsForLabel(lblTitle, guide: margins))
        constraints.append(contentsOf: constraintsForLabel(lblDescription, guide: margins))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func constraintsForLabel(_ label: UILabel, guide: UILayoutGuide)
        -> [NSLayoutConstraint] {
            
            [label.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
             label.trailingAnchor.constraint(equalTo: guide.trailingAnchor)]
    }
}
