//
//  PostTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 23.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet  weak var textView: UITextView!
  @IBOutlet private weak var postImageView: UIImageView!
  @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
      
   //   textView.sizeToFit()
   //   textView.isScrollEnabled = false
  }
}
extension PostTableViewCell {
  func sutup(with post: Post) { // загрузить пост
    textView.text = post.text ?? ""
    if let imageData = post.imageData {
      postImageView.image = UIImage(data: imageData)
      imageViewHeightConstraint.constant = Sizes.postImageHeight
    } else {
      imageViewHeightConstraint.constant = Sizes.zero
    }
  }
}
private extension PostTableViewCell {
  enum Sizes {     // расположения 
    static let zero: CGFloat = 0
    static let postImageHeight: CGFloat = 300
  }
}
