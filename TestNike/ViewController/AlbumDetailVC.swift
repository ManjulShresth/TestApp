//
//  AlbumDetailVC.swift
//  TestNike
//
//  Created by Manjul Shrestha on 8/3/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailVC: UIViewController{
    
    var feedResult : FeedResult?
    let albumDetailScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var scrollViewContent : UIView = {
        

        
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(self.albumImageView)
        view.addSubview(self.albumName)
        view.addSubview(self.artistName)
        view.addSubview(self.genre)
        view.addSubview(self.copyrightInfo)
        view.addSubview(self.releaseDate)
        view.addSubview(self.openAlbumBtn)
        

        self.albumImageView.translatesAutoresizingMaskIntoConstraints = false
        self.albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        self.albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        self.albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.albumImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.albumName.translatesAutoresizingMaskIntoConstraints = false
        self.albumName.topAnchor.constraint(equalTo: self.albumImageView.bottomAnchor, constant: 5).isActive = true
        self.albumName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.albumName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        self.artistName.translatesAutoresizingMaskIntoConstraints = false
        self.artistName.topAnchor.constraint(equalTo: self.albumName.bottomAnchor, constant: 5).isActive = true
        self.artistName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.artistName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        self.genre.translatesAutoresizingMaskIntoConstraints = false
        self.genre.topAnchor.constraint(equalTo: self.artistName.bottomAnchor, constant: 5).isActive = true
        self.genre.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.genre.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        self.copyrightInfo.translatesAutoresizingMaskIntoConstraints = false
        self.copyrightInfo.topAnchor.constraint(equalTo: self.genre.bottomAnchor, constant: 5).isActive = true
        self.copyrightInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.copyrightInfo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        self.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDate.topAnchor.constraint(equalTo: self.copyrightInfo.bottomAnchor, constant: 5).isActive = true
        self.releaseDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.releaseDate.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true

        self.openAlbumBtn.translatesAutoresizingMaskIntoConstraints = false
        self.openAlbumBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        self.openAlbumBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.openAlbumBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        self.openAlbumBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        self.openAlbumBtn.topAnchor.constraint(equalTo: self.releaseDate.bottomAnchor).isActive = true
        self.openAlbumBtn.addTarget(self, action: #selector(openItunes(_:)), for: .touchUpInside)
        self.openAlbumBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true

        return view
        
    }()
    
    lazy var albumImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let albumUrl = self.feedResult?.artworkUrl100 {
            imageView.imageFromServerURL(albumUrl, placeHolder: nil)
        }
        return imageView
    }()

    lazy var albumName : UILabel = {
       let label = UILabel()
        label.text = self.feedResult?.name
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var artistName : UILabel = {
       let label = UILabel()
        label.text = self.feedResult?.artistName
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center

        return label
    }()
    
    lazy var genre : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        guard let genres = self.feedResult?.genres else { return label }
        var genreName : String = ""
        for genre in genres{
            if let name = genre.name, genre.name != genres.last?.name{
                genreName = name + ", "
            }
            else if let name = genre.name{
                genreName += name
            }
        }
        label.text = genreName
        return label
    }()

    lazy var copyrightInfo : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.text = self.feedResult?.copyright
       return label
    }()

    lazy var releaseDate : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = self.feedResult?.releaseDate
        return label
    }()


    
    lazy var openAlbumBtn : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Open iTunes Store", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumDetailScrollView.addSubview(scrollViewContent)
        scrollViewContent.anchor(top: albumDetailScrollView.topAnchor, leading: albumDetailScrollView.leadingAnchor, bottom: albumDetailScrollView.bottomAnchor, trailing: albumDetailScrollView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        scrollViewContent.widthAnchor.constraint(equalTo: albumDetailScrollView.widthAnchor).isActive = true
        let heightConstraint = scrollViewContent.heightAnchor.constraint(equalTo: albumDetailScrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        heightConstraint.isActive = true

        //add scroll view to view
        self.view.addSubview(self.albumDetailScrollView)
        self.albumDetailScrollView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)

    }
    
    @objc func openItunes(_ sender: Any){
        if let albumID = self.feedResult?.id{
            let itunesURL = "itms://itunes.apple.com/album/\(albumID)"
            if let url = URL(string: itunesURL){
                UIApplication.shared.openURL(url)
            }
        }
    }

    
    static func launchDetailVC(viewController: UIViewController, album: FeedResult){
        let detailVC = AlbumDetailVC()
        detailVC.feedResult = album
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}


class TestScrollView: UIScrollView{
    let scrollViewContent : UIView = {
        let view = UIView()
        return view
    }()

}
