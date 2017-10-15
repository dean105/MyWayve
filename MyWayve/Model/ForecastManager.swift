//
//  ForecastManager.swift
//  MyWayve
//
//  Created by Dean Parreno on 5/10/17.
//  Copyright © 2017 DeanParreno. All rights reserved.
//

import Alamofire
import CoreLocation
import Foundation

class ForecastManager {
    
    func fetchForecast(completion: @escaping (MultiDayForecast?) -> Void) {
        Alamofire.request(
            Configuration.forecastURL(for: CLLocationCoordinate2D(latitude: -33.73176, longitude: 151.30146))!,
            method: .get,
            parameters: nil)
            .validate()
            .responseJSON { (response) -> Void in
                let forecast: MultiDayForecast?
                switch response.result {
                case .failure(let error):
                    print(error)
                    forecast = nil
                case .success(let data):
                    guard let json = data as? [String : AnyObject],
                        let dataDictionary = json["data"] as? [String : AnyObject]
                        else { return }
                    forecast = MultiDayForecast(with: dataDictionary)
                }
                completion(forecast)
        }
    }
}
