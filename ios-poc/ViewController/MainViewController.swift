//Created on 6/4/20

import Foundation
import UIKit

class MainViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let dataProvider: DataProvider?
    private var countryInfoItems: [CountryInfoItem] = []
    
    // MARK: - Initializer
    
    init(withDataProvider dataProvider: DataProvider = APIDataProvider()) {
        self.dataProvider = dataProvider
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
        fetchData()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupTableView() {
        tableView?.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView?.allowsSelection = false
    }
    
    // MARK: - Refresh / API Calls 
    
    @objc func refresh(sender: AnyObject) {
        fetchData()
    }

    func fetchData(completion: (() -> Void)? = nil) {
        dataProvider?.fetchCountryInfo(completion: { [weak self] response, error in
            if let _ = error {
                return
            }
            guard let response = response else { return }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.onSuccess(response: response)
                completion?()
            }
        })
    }

    func onSuccess(response: CountryInfo) {
        self.title = response.title ?? ""
        self.countryInfoItems = response.countryItems()
        tableView?.reloadData()
    }
}

// MARK: - TableView DataSource

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryInfoItems.count
    }
}

// MARK: - TableView Delegate

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        weak var tv = tableView
        cell.redrawCallback = {
            tv?.beginUpdates()
            tv?.endUpdates()
        }
        
        if let item = item(atIndexPath: indexPath) {
            cell.countryInfoItem = item
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
