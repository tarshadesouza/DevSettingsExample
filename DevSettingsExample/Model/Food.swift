//
//  Food.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import UIKit

struct Foods: Codable {
	let foodResults: [Result]
}

struct Result: Codable {
	let title: String
	let href: String
	let ingredients: String
	let thumbnail: String
}


struct FoodViewObject {
	var data: [Result]
}
