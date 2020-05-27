//
//  ImagePicker.swift
//  Remember
//
//  Created by App-Designer2 . on 16.05.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show : Bool
    @Binding var image : Data
    var sourceType : UIImagePickerController.SourceType = .camera
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(father1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext <ImagePicker>) -> UIImagePickerController  {
        
        let picker = UIImagePickerController()
        //now the image must to be present
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext <ImagePicker>) {
        
    }
    //Coordinator goes here
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
        var father : ImagePicker
        init(father1 : ImagePicker) {
            father = father1
        }
        func imagePickerControllerDidCancel(_ picker : UIImagePickerController) {
            self.father.show.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage]as! UIImage
            let datos = image.jpegData(compressionQuality: 0.50)
            self.father.image = datos!
            self.father.show.toggle()
            
            //This is how we implement the imagepicker in SwiftUI
            //In the next video we will implement the UISearchBar
            //I hopw you like it, and dont forget to subscribe,like, and share with others
            //This is a serie from Start to Finish
            //See you on the next One
        }
    }
    
}


