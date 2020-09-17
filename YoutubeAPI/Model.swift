//
//  Model.swift
//  YoutubeAPI
//
//  Created by Đạt on 23/07/2020.
//  Copyright © 2020 Đạt. All rights reserved.
//

import Foundation
import Alamofire
protocol ModelDelegate {
   func FetchesVideo(_ video:[Item])
}
class Model {
    var delegate : ModelDelegate?
    func getVideos() -> Void {
        let url:String = "https://content.googleapis.com/youtube/v3/search?q=&type=video&maxResults=20&part=snippet&key=AIzaSyCiBq_NH4wtQJ2BCJMMYIEmNF57Fcrgj80"
        Alamofire.request(url, method: .get, encoding: URLEncoding.queryString, headers: nil)
            .validate()
            .responseJSON { response in
               switch (response.result) {
                case .success( _):
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let datareponse = try decoder.decode(ApiResponses.self, from: response.data!)
                            if datareponse.items != nil{
                                self.delegate?.FetchesVideo(datareponse.items!)
                            }
                        }
                        catch let error as NSError {
                                            print("Failed to load: \(error.localizedDescription)")
                       }
                    
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                }
        }
    }
}

