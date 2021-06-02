//
//  MyCell.swift
//  layoutTest
//
//  Created by 檀上伸郎 on 6/2/21.
//

import UIKit

class MyCell: UITableViewCell {
    var title: String? = nil {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
            setNeedsUpdateConstraints()
        }
    }
    var detail: String? = nil {
        didSet {
            detailLabel.text = detail
            detailLabel.sizeToFit()
            setNeedsUpdateConstraints()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func updateConstraints() {        
        let titleWidth = (title as NSString? ?? "").size(withAttributes: [NSAttributedString.Key.font: titleLabel.font!]).width
        let detailWidth = (detail as NSString? ?? "").size(withAttributes: [NSAttributedString.Key.font: detailLabel.font!]).width
        
        self.contentView.constraints
            .filter { ($0.identifier ?? "").hasPrefix("runtime") }
            .forEach { self.contentView.removeConstraint($0) }
        
        if titleWidth + detailWidth
            + self.directionalLayoutMargins.leading
            + self.directionalLayoutMargins.trailing
            + 20
            > self.contentView.frame.width {
            let cA = titleLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -5)
            cA.identifier = "runtime"
            cA.isActive = true
            let cB = detailLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor)
            cB.identifier = "runtime"
            cB.isActive = true
        } else {
            let cC = titleLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
            cC.identifier = "runtime"
            cC.isActive = true
            let cD = detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 10)
            cD.identifier = "runtime"
            cD.isActive = true
        }
        super.updateConstraints()
    }
 
}
