//Created on 6/4/20

import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    
    // MARK: - Methods
    
    func showCountryInfo(_ countryInfoModel: CountryInfoModel)
    func showError(_ error: APIError)
}

// MARK: -

class CountryInfoViewController: UITableViewController, PresenterToViewProtocol {
    
    // MARK: - Properties
    
    let cellIdentifier = "CustomTableViewCell"
    private var countryInfoItems: [CountryInfoItem] = []
    var presenter: ViewToPresenterProtocol?
    
    // MARK: - Initializer
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTableView()

        presenter?.updateView()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupTableView() {
        tableView?.register(CustomTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView?.allowsSelection = false
    }
    
    // MARK: - Refresh / API Calls 
    
    @objc func refresh(sender: AnyObject) {
        presenter?.updateView()
    }
    
    func showCountryInfo(_ countryInfoModel: CountryInfoModel) {
        refreshControl?.endRefreshing()
        self.title = countryInfoModel.title ?? ""
        self.countryInfoItems = countryInfoModel.countryItems()
        tableView?.reloadData()
    }
    
    func showError(_ error: APIError) {
        refreshControl?.endRefreshing()
        /* We can add/modify a UI element here to display error */
//        self.title = error.localizedDescription
    }
}

// MARK: - TableView DataSource

extension CountryInfoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryInfoItems.count
    }
}

// MARK: - TableView Delegate

extension CountryInfoViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let customCell = cell as? CustomTableViewCell {
            
            // Redraw callback is set before setting item because it is needed there.
            weak var tv = tableView
            customCell.redrawCallback = {
                if (tv?.isDragging ?? true) || (tv?.isDecelerating ?? true) {
                    return
                }
                tv?.reloadRows(at: [indexPath], with: .fade)
            }
            
            if let item = item(atIndexPath: indexPath) {
                customCell.countryInfoItem = item
            }
        }
        
        return cell
    }
    
    private func item(atIndexPath indexPath: IndexPath) -> CountryInfoItem? {
        
        guard indexPath.row >= 0 && indexPath.row < countryInfoItems.count else {
            return nil
        }
        
        return countryInfoItems[indexPath.row]
    }
}
