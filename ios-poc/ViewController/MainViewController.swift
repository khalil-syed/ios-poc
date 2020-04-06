//Created on 6/4/20

import Foundation
import UIKit

class MainViewController: UITableViewController {
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo Table"
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
}

// MARK: - TableView DataSource

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
}

// MARK: - TableView Delegate

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel!.text = "Cell at row \(indexPath.row)"
        return cell
    }
}
