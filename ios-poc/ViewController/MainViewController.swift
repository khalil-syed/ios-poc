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
        tableView?.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView?.allowsSelection = false
        fetchData()
    }
}

// MARK: - API Calls

extension MainViewController {
    
    private func fetchData() {
        dataProvider?.fetchCountryInfo(completion: { [weak self] response, error in
            if let _ = error {
                return
            }
            guard let response = response else { return }
            DispatchQueue.main.async {
                self?.onSuccess(response: response)
            }
        })
    }
    
    private func onSuccess(response: CountryInfo) {
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
        
        if let item = item(atIndexPath: indexPath) {
            cell.countryInfoItem = item
        }
        
        weak var tv = tableView
        cell.redrawCallback = {
            tv?.beginUpdates()
            tv?.endUpdates()
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
