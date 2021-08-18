//
//  ViewController.swift
//  Sin-CABasicAnimation
//
//  Created by 大西玲音 on 2021/08/18.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var waveView: WaveView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        waveView.create()
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = indexPath.row == 0 ? "" : String(indexPath.row)
        return cell
        
    }
    
}

