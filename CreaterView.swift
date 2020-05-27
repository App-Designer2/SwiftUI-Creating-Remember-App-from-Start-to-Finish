//
//  CreaterView.swift
//  Remember
//
//  Created by App-Designer2 . on 13.05.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//

import SwiftUI

struct CreaterView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State var show = false
    @State var image : Data = .init(count: 0)
    @State var names = ""
    @State var detail = ""
    @State var date = ""
    
    @State var sourceType : UIImagePickerController.SourceType = .camera
    @State var photo = false
   // @ObservedObject var users = EditView()
    
    @State var flash = false
    
    @State var ani = false
    
    @State var create = false
    var body: some View {
        NavigationView {
            
            VStack(spacing: 12) {
                
                if self.image.count != 0 {
                    Button(action: {
                        //when i tapped photo the actionSheet will appear and we could chooce one of the option!!
                        self.photo.toggle()
                    }) {
                        Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(6)
                        
                    }
                } else {
                    Button(action: {
                        self.photo.toggle()
                    }) {
                        ZStack {
                        
                        Image("camera")
                            .renderingMode(.original)
                        .resizable()
                            .frame(width: 70, height: 60)
                            
                            withAnimation(Animation.default.delay(0.2)) {
                                
                                Circle()
                                    .fill(self.flash ? Color.white : Color.white.opacity(0.40))
                                    .frame(width: 12, height: 12)
                                    .offset(x: 7, y: 3)
                            }.animation(Animation.default.delay( self.flash ? 0.6 : 0.10).repeatForever(autoreverses: self.flash))
                                .onAppear {
                                    self.flash.toggle()
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    
                    Group {
                        Text("Persons name").bold()
                    
                    TextField("Name the person on the picture...", text: self.$names)
                
                 Rectangle()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 1)
                    }
                    
                    Group {
                        Text("Description").bold()
                        
                TextField("Describe those moment...", text: self.$detail)
                
                    Rectangle()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 1)
                    }
                    
                    Group {
                Text("Picture date")
                    
                TextField("Date of the taken picture...", text: self.$date)
                    
                    Rectangle()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 1)
                    }
                }.padding()
                //Sorry the fan from my mac is so loud
                // And its hot now, because of this, it got slow
                Button(action: {
                    //When we tapp this button, the alert will pop up in front, and we will decide to add the remember or not
                    
                    self.create.toggle()
                    
                    //after press this button all the info will appear on the contentView as you see on the simulator
                }) {
                    Text("Create new")
                    .bold()
                    .padding()
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                }.background(self.image.count != 0 && self.names.count > 5 && self.detail.count > 10 && self.date.count >= 10 ? Color.init("navi") : Color.gray)
                  //
                    .cornerRadius(10)
                //Disable the button if the user doesnt input anything
                    // Button is disabled cause i haven't put anything , lets put sth
                    .disabled((self.image.count != 0 && self.names.count > 5 && self.detail.count > 10 && self.date.count >= 10 ) ? false : true)
                
                //Start
                if self.image.count != 0 {
                    Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(14)
                } else {
                    withAnimation(Animation.default.delay(0.1).repeatForever(autoreverses: self.ani)) {
                        HStack {
                            Text("Preview")
                                .fontWeight(.heavy)
                            
                            Image(systemName: "photo")
                                .foregroundColor(Color.init("navi"))
                            
                        }.foregroundColor(Color.init("navi"))
                        .scaleEffect(self.ani ? 1.20 : 1.50)
                    }.animation(Animation.default.speed(0.1).repeatForever(autoreverses: self.ani).delay(self.ani ? 1.0 : 1.0))
                    
                        .onAppear {
                            self.ani.toggle()
                    }
                }
                //End
                //I will show you why it cratch
                Spacer()
                }.padding()//Main VSTack
            
       
            
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(leading: Text("Add Remembers").foregroundColor(.white), trailing:
                    
                    Button(action: {
                        self.dismiss.wrappedValue.dismiss()
                    }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                    }
            )
                //Alert create goes here
                .alert(isPresented: self.$create) {
                    Alert(title: Text("New Remember"), message: Text("Would you like to add \(names.uppercased())?"), primaryButton: .default(Text("Yes 😊")) {
                        //Start
                        let new = Remmebers(context: self.moc)
                        new.names = self.names
                        new.imageD = self.image
                        new.detail = self.detail
                        new.date = self.date
                        
                        //This will save the data in coredata
                        try? self.moc.save()
                        
                        self.names = ""
                        self.image.count = 0
                        self.detail = ""
                        self.date = ""
                        
                        
                        self.dismiss.wrappedValue.dismiss()
                        //End
                        }, secondaryButton: .default(Text("No 😢")) {
                        self.dismiss.wrappedValue.dismiss()
                        })
            }
                
                
                //I hope you like this tutorial
                //Dont forget to subscribe + like + share with others, See you in the next one.
                .actionSheet(isPresented: self.$photo) {
                    ActionSheet(title: Text("Select Photo"), message: Text(""), buttons: [ .default(Text("Camera")) {
                        self.sourceType = .camera
                        self.show.toggle()
                        
                        }, .default(Text("Photo Library")) {
                            self.sourceType = .photoLibrary
                            self.show.toggle()
                        }, .cancel()])
                    
                    //I dont chooce the camera cause it will cratch on the simulator, for it we have use a real device.
                    //i will show you
            }
        }.sheet(isPresented: self.$show) {
            ImagePicker(show: self.$show, image: self.$image,sourceType: self.sourceType)
            //Now lets see if our actionSheet appear after we tapp the photo
                
            //I hope you like it and dont forget to subscribe + like + share with others and comment if you have any question or what you want to learn next.
            // See you on the next one.
            // We are almos in the end of this series.
        }
        
        
    }
}

struct CreaterView_Previews: PreviewProvider {
    static var previews: some View {
        CreaterView()
    }
}

