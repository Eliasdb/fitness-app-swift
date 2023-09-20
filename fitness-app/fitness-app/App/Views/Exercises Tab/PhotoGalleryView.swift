//
//  PhotoGalleryView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct PhotoGalleryView: View {
    @Query private var photos: [Photo]
    @ObservedObject var vm = ExercisesViewModel()
    @Binding var selectedPhotoCategory: String
    @Binding var categoriesString: [String]
    @Binding var createNewPhoto: Bool

    var body: some View {
        Section {
            NavigationLink {
                VStack(spacing: 0, content: {
                    VStack(alignment: .center, spacing: 0, content: {
                        Form {
                                Section {
                                           Picker("Select a category", selection: $selectedPhotoCategory){
                                               ForEach(categoriesString, id: \.self) { item in
                                                   Text(item)
                                               }
                                           }.pickerStyle(.navigationLink)
                                       }
                        }.frame(height:100)
                        Section {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(vm.filterPhotos(photos: photos, selectedPhotoCategory: selectedPhotoCategory)) { item in
                                        ZStack(alignment: .bottom) {
                                            Image(uiImage: UIImage(data: item.image!)!)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(minWidth: 300, maxHeight: 450)
                                            VStack(spacing: 0) {
                                                Rectangle()
                                                    .fill(.white)
                                                    .frame(height: 3)

                                                HStack(alignment: .top) {
                                                    VStack(alignment: .leading) {
                                                        Text("\(item.imageCategory)")

                                                        Text("\(item.dateAsString)")
                                                            .font(.body)
                                                    }
                                                    Spacer()
                                                }
                                                .font(.title3.bold())
                                                .padding(10)
                                                .padding(.horizontal, 10)
                                                .background(.mint)
                                                .foregroundStyle(.black)
                                                .frame(maxWidth: .infinity)
                                            }
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                        .shadow(color: .black.opacity(0.2), radius: 2)
                                        .padding(4)
                                        .containerRelativeFrame(.horizontal)
                                    }
                                }
                                    .scrollTargetLayout()
                                
                            }.scrollIndicators(.hidden)
                                .scrollTargetBehavior(.viewAligned)
                                .contentMargins(20, for: .scrollContent)
                                .listRowInsets(EdgeInsets())
                        }
                        Spacer()
                    })
                })
                .overlay(alignment: .bottomTrailing, content: {
                    VStack {
                        Button(action: {
                            createNewPhoto.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 55, height: 55)
                                .background(.indigo.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10 )), in: .circle)
                        })
                        .padding(15)
                    }
                })
              
                .sheet(isPresented: $createNewPhoto, content: {
                    AddPhotoView()
                        .presentationDetents([.height(520)])
                        .interactiveDismissDisabled()
                        .presentationCornerRadius(30)
                        .presentationBackground(.white)
                })

            } label : {
                PhotoGalleryDetailView()
            }
        }
    }
}

//#Preview {
//    PhotoGalleryView()
//}
