//
//  URLImage.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 28/10/2020.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
	
	@Published var downloadedImage: UIImage?
	
	func load(url: String) {
		
		guard let imageURL = URL(string: url) else {
			return
		}
		
		URLSession.shared.dataTask(with: imageURL) { data, response, error in
			
			guard let data = data, error == nil else {
				return
			}
			
			DispatchQueue.main.async {
				self.downloadedImage = UIImage(data: data)
			}
		}.resume()
	}
}

struct URLImage: View {
	
	@ObservedObject private var imageLoader = ImageLoader()
	
	var placeholder: Image
	
	init(url: String, placeholder: Image = Image(systemName: "photo")) {
		self.placeholder = placeholder
		self.imageLoader.load(url: url)
	}
	
	var body: some View {
		if let uiImage = self.imageLoader.downloadedImage {
			return Image(uiImage: uiImage)
		} else {
			return placeholder
		}
	}
}
