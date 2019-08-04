//
//  NewsCell.swift
//  20_NewsReader
//
//  Created by Chrissy Satyananda on 03/08/19.
//  Copyright © 2019 Odjichrissy. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var labelJudul: UILabel!
    
    var link: NewsTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let bookmarkButton = UIButton(type: .system)
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        bookmarkButton.tintColor = .blue
        bookmarkButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        accessoryView = bookmarkButton
    }
    
    @objc private func handleMarkAsFavorite() {
        link?.bookmarkFunction(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
