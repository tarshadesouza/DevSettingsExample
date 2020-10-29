//
//  EndPoints.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import Alamofire

public enum FoodEndPoints {
	case retrieveData
}

extension FoodEndPoints {
	
	var httpMethod: HTTPMethod {
		switch self {
		case .retrieveData:
			return .get
		}
	}
	
	var baseURLString: String {
		switch self {
		case .retrieveData:
			return "http://www.recipepuppy.com"
		}
	}
	
	var path: String? {
		switch self {
		case .retrieveData:
			return "/api/"
		}
	}
//	?ingr=apple
	var params: [String: Any]? {
		switch self {
		case .retrieveData:
//			return ["app_id" : "f280b053",
//					"app_key" : "46f6a5298bb0d72c9898740c84355c04"]
			return ["q": "apple"]
		}
	}
	
	var headers: HTTPHeaders {
		switch self {
		case .retrieveData :
			return  ["Content-Type": "application/json"]
		}
	}
	
	public func asURLRequest() throws -> URLRequest {
		let url = try baseURLString.asURL()
		
		var request = URLRequest(url: url.appendingPathComponent(path ?? ""))
		request.httpMethod = httpMethod.rawValue
		request.timeoutInterval = TimeInterval(10 * 1000)
		
		return try URLEncoding.default.encode(request, with: params)
	}
}
