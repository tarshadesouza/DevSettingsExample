//
//  Food.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import UIKit

struct Foods: Codable {
	let results: [Result]
}

class Result: Codable {
	var title: String
	var href: String
	var ingredients: String
	var thumbnail: String
}
