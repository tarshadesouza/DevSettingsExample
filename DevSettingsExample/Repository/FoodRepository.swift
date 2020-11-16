//
//  FoodRepository.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

typealias FoodResult = Swift.Result<Foods, AFError>

protocol FoodRepositoryProtocol {
	func retrieveData()
}

/// Manages connection to the backend 
class FoodRepository: BaseRepository, FoodRepositoryProtocol, ObservableObject {
	@Published var foodList = Foods(results: [])
	
	init() {
		super.init(manager: RequestManager())
	}
	
	func retrieveData() {
		let queryObj = FoodEndPoints.retrieveData
		manager.request(queryObj)?.logResponse().responseDecodable { (response: DataResponse<Foods, AFError>) in
			switch response.result {
			case .success(let data):
				self.foodList = data
			case .failure:
				break
			}
		}
	}
}

extension Alamofire.DataRequest {
	func logResponse() -> Self {
		return responseJSON { response in
			print("** REQUEST URL: \(String(describing: response.request?.url))")
			if let httpBody = response.request?.httpBody,
				let paramsString = String(data: httpBody, encoding: String.Encoding.utf8) {
				print("** REQUEST Params: \(paramsString)")
			}
			
			switch response.result {
			case .success(let json):
				print("** RESPONSE: # --> #\(json))# #")
			case .failure(let error):
				print("** ERROR LOGGING RESPONSE: \(error.localizedDescription)")
			}
		}
	}
}
