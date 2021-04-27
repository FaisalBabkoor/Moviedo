//
//  MovieCell.swift
//  Moviedo
//
//  Created by Faisal Babkoor on 4/23/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var imageMovie: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var rate: UILabel!
    @IBOutlet var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 15
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowOffset = CGSize(width: 3, height: 2)
        imageMovie.layer.cornerRadius = 8
    }
    
    func configure(_ movie: Movie1) {
        name.text = movie.name
        rate.text = "\(movie.rate)"
        let types = movie.types.map{$0.rawValue}
        type.text = types.joined(separator: ", ")
        imageMovie?.image = movie.image
    }
}
