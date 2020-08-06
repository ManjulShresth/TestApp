//
//  AlbumTableVC.swift
//  TestApp
//
//  Created by Manjul Shrestha on 8/3/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation
import UIKit

class AlbumTableVC: UIViewController{
    
    var feedDataModel: FeedDataModel?
    var albumArray = [FeedResult]()
    
    let albumTable : UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        return table
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.albumTable.dataSource = self
        self.albumTable.delegate = self
        self.albumTable.register(AlbumTableCell.self, forCellReuseIdentifier: "AlbumCell")
        self.view.addSubview(albumTable)
        
        self.albumTable.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        self.populate()
    }
    
    func populate(){
        NetworkManager.shared.fetchRSSFeed { (feedResult) in
            switch feedResult{
            case .success(let feedDataModel):
                self.feedDataModel = feedDataModel
                if let results = feedDataModel.feed?.results{
                    for result in results{
                        if result.kind == "album"{
                            self.albumArray.append(result)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.albumTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AlbumTableVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = self.albumArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableCell
        cell.albumNameLabel.text = result.name
        cell.albumArtistLabel.text = result.artistName
        if let albumUrl = result.artworkUrl100 {
            cell.albumImage.imageFromServerURL(albumUrl, placeHolder: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = self.albumArray[indexPath.row]
        AlbumDetailVC.launchDetailVC(viewController: self, album: result)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


}


class AlbumTableCell : UITableViewCell{
    
    let albumNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()

    let albumArtistLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let albumImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(albumNameLabel)
        self.addSubview(albumArtistLabel)
        self.addSubview(albumImage)
        
        self.albumNameLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, paddingTop: 5, paddingLeft: 80, paddingBottom: 0, paddingRight: 5, width: 0, height: 20, enableInsets: true)
        self.albumArtistLabel.anchor(top: albumNameLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, paddingTop: 5, paddingLeft: 80, paddingBottom: 0, paddingRight: 5, width: 0, height: 20, enableInsets: true)
        self.albumImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 70, height: 50, enableInsets: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
