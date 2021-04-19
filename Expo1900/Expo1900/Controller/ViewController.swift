//
//  ViewController.swift
//  Expo1900
//
//  Created by Ryan-Son on 2021/04/17.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet private weak var tableView: UITableView!
  private var artworks: [Artwork] = []
  
  // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

      let decodedResult: Result = ExpoJSONDecoder.decode(to: [Artwork].self,from: ExpoData.artworks)
      
      switch decodedResult {
      case .success(let result):
        artworks = result
      case .failure(let error):
        debugPrint(error)
      }
    }
  
  
}
