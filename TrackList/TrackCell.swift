//
//  TrackCell.swift
//  TrackList
//
// Author: Guadarrama Ortega César Alejandro
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var tittle: UILabel!
   @IBOutlet weak var portada: UIImageView!
    
    var track: Track!{
        didSet{
            tittle.text = track.trackName
            guard let url = URL(string: track.artworkUrl100 ?? "") else {return}
            
            URLSession.shared.dataTask(with: url){ (data, response,error) in print("Descargando la imagen",data)
                guard let dataImage = data else{return}
                DispatchQueue.main.async {
                    self.portada.image = UIImage(data: dataImage)
                }
            }.resume()
            
        }
    }
}
    
