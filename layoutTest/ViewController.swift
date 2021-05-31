//
//  ViewController.swift
//  layoutTest
//
//  Created by 檀上伸郎 on 2021/05/28.
//

import UIKit

class ViewController: UITableViewController {
    let array = [
        ["test", "foobar"],
        ["長いタイトル長いタイトル長いタイトル", "長いdetail長いdetail長いdetail"],
        ["test test", "foobar foobar"],
        ["test test test", "foobar foobar foobar"],
        ["test test test", "foobar foobar foobar foobar"],
        ["test test test", "foobar foobar foobar foobar foobar"],
        ["test test test test", "foobar foobar foobar foobar"],
        ["test test test testt", "foobar foobar foobar foobar"],
        ["test test test test", "foobar foobar foobar foobarr"],
        ["test test test test", "foobar foobar foobar foobarrr"],
        ["test test test test", "foobar foobar foobar foobarrrr"],
        ["test test test test", "foobar foobar foobar foobar foobar"],
        ["test test test test", "foobar foobar foobar foobar foobar foobar"],
        ["test test test", "foobar foobar foobar foobar foobar foobar"],
        ["test test test", "foobar foobar foobar foobar foobar foobar foobar"],
    ]

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // cell.accessoryType = .disclosureIndicator
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let detailLabel = cell.viewWithTag(2) as! UILabel
        
        let row = array[indexPath.row]
        /*
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        */
        titleLabel.text = row[0]
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor.label
        titleLabel.sizeToFit()
        detailLabel.text = row[1]
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailLabel.textColor = UIColor.secondaryLabel
        detailLabel.sizeToFit()
        
        cell.contentView.constraints
            .filter { $0.identifier?.hasPrefix("runtime_") ?? false }
            .forEach { cell.contentView.removeConstraint($0) }
        
        if titleLabel.frame.width + detailLabel.frame.width
            + cell.contentView.directionalLayoutMargins.leading
            + cell.contentView.directionalLayoutMargins.trailing
            + 20 // magic numbert
            > tableView.contentSize.width {
            let cA = detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            cA.identifier = "runtime_cA"
            cA.isActive = true
            let cB = detailLabel.leadingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leadingAnchor)
            cB.identifier = "runtime_cB"
            cB.isActive = true
            let cC = titleLabel.trailingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.trailingAnchor)
            cC.identifier = "runtime_cC"
            cC.isActive = true
        } else {
            let cD = titleLabel.bottomAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.bottomAnchor, constant: -2)
            cD.identifier = "runtime_cD"
            cD.isActive = true
            let cE = detailLabel.topAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.topAnchor, constant: 2.5)
            cE.identifier = "runtime_cE"
            cE.isActive = true
            let cF = titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: detailLabel.leadingAnchor, constant: 0)
            cF.identifier = "runtime_cF"
            cF.isActive = true
        }
        return cell
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }

}

