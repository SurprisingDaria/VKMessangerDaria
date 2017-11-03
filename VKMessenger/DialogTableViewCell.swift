//
//  DialogTableViewCell.swift
//  VKMessenger
//
//  Created by Daria Smirnova on 22.05.17.
//  Copyright © 2017 Daria Smirnova. All rights reserved.
//

import UIKit
import SDWebImage

class DialogTableViewCell: UITableViewCell

{
    @IBOutlet weak var avatar: UIImageView!

  
    @IBOutlet weak var title: UILabel!
    

    @IBOutlet weak var messageText: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    
    func configureSelf (dialog: Dialog)
    
    {
        self.title.text = dialog.title
        self.messageText.text = dialog.snippet
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        self.time.text = dateFormatter.string(from: dialog.date)
        
        avatar.sd_setImage (with: URL (string: dialog.dialogAvatar))
        
    }
}
