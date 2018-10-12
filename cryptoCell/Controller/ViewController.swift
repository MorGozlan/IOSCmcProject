//
//  ViewController.swift
//  cryptoCell
//
//  Created by HackerU on 23/08/2018.
//  Copyright © 2018 HackerU. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var mainView: UIView!;
    
    @IBOutlet weak var alertView: UIView!;
    
    @IBOutlet weak var chatImageView: UIImageView!
    
    @IBOutlet weak var symbolAlert: UILabel!
    
    @IBAction func closeAleret(_ sender: Any) {
        alertView.isHidden = true
    }
    
    
    var searchBarShown = false;
    var cryptos : [CryptoData] = []
    var filteredCryptos : [CryptoData] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        
        
        
        //NavBar
        // Only execute the code if there's a navigation controller
        if self.navigationController == nil {
            return
        }
        
        // Create a navView to add to the navigation bar
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = " My CoinMarketCap"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "icons8-bitcoin-24")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIViewContentMode.scaleAspectFit
        
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
        
        //self.navigationItem.titleView = UIImageView(image: UIImage(named: "icons8-bitcoin-24"))
        //self.navigationItem.title = "My CoinMarketCap"
        
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        loadData();
    }
    private func loadData(){
        CMCManager.manager.getCryptoData { cryptoDataArray in
            self.cryptos = cryptoDataArray
            self.filteredCryptos = cryptoDataArray
            self.tableView.reloadData()
        }
    }
    

    //MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCryptos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell")! as! CryptoCell
        
        cell.layer.borderWidth = 1;
        
        cell.setData(filteredCryptos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertView.isHidden = false
        let crypto = cryptos[indexPath.row]
        print(crypto.chartURLString)
        if let url = URL(string: crypto.chartURLString) {
            chatImageView.contentMode = .scaleAspectFit
            downloadImage(from: url)
            symbolAlert.text = crypto.symbolName
        }
        
        
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.chatImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
    //MARK: - UISearch Bar Delegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredCryptos = cryptos
        searchBar.resignFirstResponder()
        
        showSearch(false);
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredCryptos = cryptos
            return
        }
        
        let text = searchText.lowercased()
        filteredCryptos = cryptos.filter({ (data) -> Bool in
            return data.name.lowercased().contains(text) || data.symbolName.lowercased().contains(text)
        })
        
    }
    
    @IBAction func showSearch(){
        print("open search");
        
        showSearch(true);
        searchBar.becomeFirstResponder();
    }
    
    
    private func showSearch(_ toShow: Bool){
        if searchBarShown == toShow{
            return
        }
        searchBarShown = toShow ;
        let delta:CGFloat = toShow ? 1 : -1;
        let h = searchBar.bounds.height;
        
            mainView.frame.origin.y += h*delta;
            mainView.frame.size.height -= h*delta;
            tableView.frame.origin.y += h*delta;
            tableView.frame.size.height -= h*delta;
        
        
    }
    


}

