//
//  RequestManager.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import Alamofire

/// Main common request manager
public class RequestManager {
	let client: Alamofire.Session
	
	public init() {
		self.client = Alamofire.Session(configuration: URLSessionConfiguration.default)
	}
	
	public func request(_ endPoints: FoodEndPoints) -> DataRequest? {
		guard let request = try? endPoints.asURLRequest() else {
			return nil
		}
		return client.request(request)
	}
}
