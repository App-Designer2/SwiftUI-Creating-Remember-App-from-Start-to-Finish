//
//  ContentView.swift
//  Remember
//
//  Created by App-Designer2 . on 12.05.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Remmebers.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Remmebers.names, ascending: true),
        NSSortDescriptor(keyPath: \Remmebers.detail, ascending: true),
        NSSortDescriptor(keyPath: \Remmebers.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Remmebers.favo, ascending: false),
        NSSortDescriptor(keyPath: \Remmebers.loved, ascending: false)
    
    ]
    ) var remebers : FetchedResults<Remmebers>
    
    @State var image : Data = .init(count: 0)
    
    @State var show = false
    
    @State var text = ""
    
    @State var alert = false
    @State var delete = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                SearchsBar(text: $text)
                //Now let add some code to active the searchbar and search sth on it
                ForEach(remebers.filter({self.text.isEmpty ? true : $0.names!.localizedCaseInsensitiveContains(self.text)}), id: \.imageD) { reme in
                    
                    VStack(alignment: .leading) {
                        Text("\(reme.names ?? "")")
                            .font(.headline)
                            .underline()
                        //Because i said to my forEach that the same name can't be added twice
                        //I wanted to add diferent image, but the same name
                        //Now i will select as id the image,
                        //and you will see it will cratch.
                        
                        //Ok it didnt cratch,but the forEach recognized the image and implemented both with the same info
                        //I hope you like it and understood it.
                        // See you in the next one.
                        Image(uiImage: UIImage(data: reme.imageD ?? self.image)!)
                            .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(14)
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { star in
                                HStack {
                                Button(action: {
                                    reme.favo = star
                                }) {
                                    Image(systemName: reme.favo >= star ? "star.fill": "star")
                                        .foregroundColor((reme.favo >= star) ? Color.yellow : Color.gray)
                                } .onTapGesture {
                                    reme.favo = star
                                    try! self.moc.save()
                                }
                            }//HStack
                            }
                            
                            Text("\(reme.date ?? "")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button(action: {
                                reme.loved.toggle()
                                try! self.moc.save()
                            }) {
                                Image(systemName: reme.loved ? "heart.fill": "heart")
                                .foregroundColor((reme.loved) ? Color.red : Color.gray)
                            }
                        }//Main HStack
                        
                        
                        Text("\(reme.detail ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }//Main VStack
                    //Here i will implement the contextMenu
                        .contextMenu {
                            
                            Button(action: {
                                //with this implementation we save images in our photo gallery from the devices
                                UIImageWriteToSavedPhotosAlbum(UIImage(data: reme.imageD ?? self.image)!, 0, nil, nil)
                                
                                self.alert.toggle()
                                //Lets run our app, to see if it works
                            }) {
                                HStack {
                                    Text("Save To Gallery")
                                    
                                    Image(systemName: "square.and.arrow.down")
                                    
                                }
                            }
                            //Like that save photos in our photo gallery
                            //And delete items from our apps
                            
                            Button(action: {
                                //and like this we will be able to delete remembers from our apps
                                
                                //Lets run our project to see if it works
                                self.delete.toggle()
                            }) {
                                HStack {
                                    Text("Delete")
                                    
                                    Image(systemName: "trash")
                                }
                            }
                    }//ContextMenu
                        
                        //Like that we implement the Alert comfirmation.
                        //Start
                    .alert(isPresented: self.$delete) {
                        Alert(title: Text("No Undo"), message: Text("Are you sure that you want to delete this remember?"), primaryButton: .default(Text("Delete")) {
                            self.delete(at: IndexSet.init(arrayLiteral: 0))
                            //Lets run our app, to see if it works
                            }, secondaryButton: .cancel())
                    }//End Alert
                    
                    //I hope you like it, and dont forget to subscribe,like and share with others.
                    //See you in the next one!!
                }.padding()//Main ForEach
                
            }//Scrollview
                .navigationBarTitle("Remember", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.show.toggle()
                }) {
                    HStack {
                       Image(systemName: "plus.circle.fill")
                        
                        Text("new")
                    }.foregroundColor(.white)
                }, trailing: ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.55))
                        .frame(width: 30, height: 30)
                    Text("\(self.remebers.count)")
                        .foregroundColor(Color.white)
                    })//.padding()
            
            //Now lets color the background from the navigationView
                .alert(isPresented: self.$alert) {
                    Alert(title: Text("Saved Photo"), message: Text("The photo was saved on your Photo Gallery"), dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: self.$show) {
            CreaterView().environment(\.managedObjectContext, self.moc)
        }
    }
    //Here we will implement the deletion function
    
    //Start
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let delet = remebers[index]
            self.moc.delete(delet)
        }
        //This will delete the items permanent
        try! self.moc.save()
    }
    //End
    
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "navi")
        
        navigationBar.standardAppearance = appearance
        
        //We are done with this video,in the next we will implement the CreaterView()
        // I hope you like and dont forget to subscribe, likes and share.
        //See you in the one
        //And please Stay Safe.
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

    
   
