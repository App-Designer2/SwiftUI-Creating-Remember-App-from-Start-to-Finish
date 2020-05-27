//
//  UISearchBar.swift
//  Remember
//
//  Created by App-Designer2 . on 17.05.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


struct SearchsBar: UIViewRepresentable {

@Binding var text: String


class Coordinator: NSObject,UISearchBarDelegate {
    
    let searchBar = UISearchBar(frame: .zero)
    
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
        
    }//init
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
        
    }//searchBar
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(true)
        
    }//searchBarShouldEndEditing
    
}//Coordinator
    
    
func makeCoordinator() -> SearchsBar.Coordinator {
    return Coordinator(text: $text)
    
}//makeCoordinator
    
    

func makeUIView(context: UIViewRepresentableContext<SearchsBar>) -> UISearchBar {
    let searchsBar = UISearchBar(frame: .zero)
    searchsBar.delegate = context.coordinator
    searchsBar.isSearchResultsButtonSelected = true
    searchsBar.placeholder = "Search name..."
    searchsBar.barStyle = .default
    searchsBar.enablesReturnKeyAutomatically = true
    
    return searchsBar
    
}//makeUIView
    
func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchsBar>) {
    uiView.text = text
    
    }//updateUIView
    
}//struct

