//Created on 7/4/20

import Foundation
import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    var redrawCallback: (() -> Void)?
    
    // MARK: - SubViews
    
    var countryInfoItem: CountryInfoItem? {
        didSet {
            guard let item = countryInfoItem else { return }
            
            if let title = item.title { lblTitle.text = title }
            if let description = item.description { lblDescription.text = description }
            loadImage(url: item.imageHref, callback: redrawCallback)
        }
    }
    
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    lazy var lblDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textColor = .darkText
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
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
    
    // MARK: - Methods
    
    func loadImage(url: String?, callback: (() -> Void)?) {
        guard let imageURL = url, imgView.image == nil else { return }
        
        imgView.loadImage(fromUrl: imageURL) {
            callback?()
        }
    }
    
    // MARK: - Overridden Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        lblDescription.text = ""
        imgView.image = nil
    }
    
    // MARK: - Private methods

    func addSubviews() {
        contentView.addSubview(imgView)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescription)
    }
    
    // MARK: Constraints
    
    func setAutoLayoutConstraints() {
        
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

// MARK: -

extension UIImageView {
    
    func loadImage(fromUrl url: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: url) else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url) { result in
            switch result {
            case .success(let successResult):
                if successResult.cacheType != .memory {
                    completion?()
                }
            case .failure(let error):
                print("Image load failed: \(error.localizedDescription)")
            }
        }
    }
}
