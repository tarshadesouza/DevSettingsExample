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
	let image: String?
	
	init(foodData: Result) {
		self.id = foodData.href
		self.name = foodData.title
		self.image =  foodData.thumbnail
	}
}

struct ContentView: View {
	let repository = FoodRepository()

	var data: [DataModel]?
	
//	let testData = [DataModel(id: "0", name: "testing1", image: UIImage()), DataModel(id: "1", name: "testing2", image: UIImage()), DataModel(id: "2", name: "testing3", image: UIImage())]
//	let testData2 = [DataModel(id: "0", name: "testdata2", image: UIImage()), DataModel(id: "1", name: "2 yeah", image: UIImage())]
	var body: some View {
		NavigationView {
			
			VStack(alignment: .leading) {
				ScrollView(.horizontal, showsIndicators: false, content: {
					HStack {
						if let dataSource = data {
							ForEach(dataSource) { items in
								CollectionView(data: items)
							}
						}
					}
				})
				
				ScrollView(.vertical, showsIndicators: false, content: {
					VStack() {
						if let dataSource = data {
							ForEach(dataSource) { items in
								CollectionView(data: items)
							}
						}
					}
				})
			}
			.navigationBarTitle("Welcome To Dev Settings")
		}.onAppear() {
			getFood()
		}
	}
	
	func getFood() {
		repository.retrieveData { (foodResult) in
			switch foodResult {
			case .success(let data):
				let foodData = data.foodResults
				let viewObjc = FoodViewObject(data: foodData)
				let model = viewObjc.data
				
			case .failure(let error):
				print(error)
			}
		}

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
	let data: DataModel
	var body: some View {
		VStack() {
			HStack {
				VStack(alignment: .center) {
					URLImage(url: self.data.image ?? "")
					Image("test")
						.resizable()
						.foregroundColor(.blue)
						.frame(width: 150, height: 100)
						.padding()
						
					Text(self.data.name)
				}
			}
			
		}
	}
}
