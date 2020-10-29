//
//  BaseRepository.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import Alamofire

class BaseRepository: NSObject {
	let manager: RequestManager
	
	internal init(manager: RequestManager = RequestManager()) {
		self.manager = manager
	}
}
