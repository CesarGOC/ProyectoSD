//
// Author: Guadarrama Ortega César Alejandro
//
import UIKit

class TracksTableViewController: UITableViewController, UISearchBarDelegate {
    
    var tracks: [Track] = []
    
    let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        searchBarController.dimsBackgroundDuringPresentation = true
        
        searchBarController.searchBar.delegate = self
        
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "celda")
        
        getTracks(cadena: "")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as? TrackCell

        cell!.track = tracks[indexPath.row]
        
        //cell.textLabel?.text = track.trackName

        //cell?.tittle.text = track.trackName
        
        return cell!
    }
    
        
    func getTracks(cadena: String){
        
        let stringConverted = cadena.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(stringConverted)")

        let jsonDecoder = JSONDecoder()

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
           
            if (error != nil){
                print(error?.localizedDescription)
            }
            
            if let data = data, let tracksList = try? jsonDecoder.decode(ResultsSearch.self, from: data){
                for track in tracksList.results{
                    print(track.trackName)
                }
                
                self.tracks = tracksList.results
                
                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
                
            }
        }
        task.resume()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 4{
            getTracks(cadena: searchText)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    

}
