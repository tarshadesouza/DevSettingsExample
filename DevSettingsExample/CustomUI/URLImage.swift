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
	
	var downloadedImage: UIImage?
	let didChange = PassthroughSubject<ImageLoader?, Never>()
	
	func load(url: String) {
		
		guard let imageURL = URL(string: url) else {
			fatalError("ImageURL is not correct!")
		}
		
		URLSession.shared.dataTask(with: imageURL) { data, response, error in
			
			guard let data = data, error == nil else {
				DispatchQueue.main.async {
					 self.didChange.send(nil)
				}
				return
			}
			
			self.downloadedImage = UIImage(data: data)
			DispatchQueue.main.async {
				self.didChange.send(self)
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
