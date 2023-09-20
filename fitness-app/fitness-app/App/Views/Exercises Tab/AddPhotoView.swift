//
//  AddPhotoView.swift
//  Dawn
//
//  Created by Elias on 19/09/2023.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
struct AddPhotoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var selectedPhotoCategory: String = "Abs"
    @State private var selectedPhotoDate: Date = .init()
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    var categories: [String] = ["Abs", "Arms", "Back", "Chest", "Legs"]

    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading)
            
            VStack(alignment: .leading, spacing: 8, content: {

                
                    Section {
                        
                        LabeledContent {
                            Picker("", selection: $selectedPhotoCategory){
                                ForEach(categories, id: \.self) { item in
                                    Text("\(item)")
                                        .font(.caption)
                                        .tag(item)
                                }
                            }
                        } label: {
                            Text("Photo category")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        LabeledContent {
                            DatePicker("", selection: $selectedPhotoDate)
                                .datePickerStyle(.compact)
                                .scaleEffect(0.9, anchor: .leading)
                        } label: {
                            Text("Photo Date")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        LabeledContent {
                            PhotosPicker(
                                selection: $selectedPhoto, matching: .images, photoLibrary: .shared())   {
                                    Label("", systemImage: "photo")
//                                        .font(.caption)
                                        .foregroundStyle(.indigo)
                                }
                        } label: {
                            Text("Photo")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        
                        if let selectedPhotoData,
                           let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        }
                        
                        
                    }.task(id: selectedPhoto) {
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                            selectedPhotoData = data
                        }
                    }
                
            })
            Spacer(minLength: 0)
            Button(action: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                let formattedPhotoDate = dateFormatter.string(from: selectedPhotoDate)
                let photo = Photo(imageCategory: selectedPhotoCategory, image: selectedPhotoData, dateAsString: formattedPhotoDate)
                        do {
                            context.insert(photo)
                            try context.save()
                            dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
            }, label: {
                Text("Add photo")
                    .font(.callout)
                    .fontWeight(.semibold)
//                                            .textScale(.secondary)
                    .foregroundStyle(.white)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color(.systemIndigo), in: .rect(cornerRadius: 10))
            })
    
        })
        .padding(15)
       
    }
}

//#Preview {
//    AddPhotoView()
//}
