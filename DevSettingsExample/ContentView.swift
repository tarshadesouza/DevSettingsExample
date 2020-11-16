//
//  ContentView.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 27/10/2020.
//

import SwiftUI

struct DataModel: Identifiable {
	var id: String
	let name: String
	let image: String
	
	init(foodData: Result) {
		self.id = foodData.href
		self.name = foodData.title
		self.image =  foodData.thumbnail
	}
	
	init(id: String, name: String, image: String) {
		self.id =  id
		self.name = name
		self.image = image
	}
}

struct ContentView: View {
	
	@ObservedObject var repository = FoodRepository()
	
	var body: some View {
		NavigationView {
			VStack(alignment: .center) {
				HStack {
					List(repository.foodList.results, id: \.href) { item in
						CollectionView(data: item)
					}
				}
			}
			.navigationBarTitle("Welcome To Dev Settings")
		}.onAppear() {
			getFood()
		}
	}
	
	 func getFood() {
		repository.retrieveData()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ContentView()
		}
	}
}

struct CollectionView: View {
	let data: Result
	var body: some View {
		VStack() {
			HStack {
				VStack(alignment: .leading) {
					URLImage(url: self.data.thumbnail)
						.frame(width: 150, height: 100)
						.padding()
					Text(self.data.title)
				}
			}
		}
	}
}
