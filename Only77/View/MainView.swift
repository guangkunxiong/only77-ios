//
//  MainView.swift
//  Only77
//
//  Created by yukun xie on 2024/1/31.
//

import SwiftUI
import Photos

struct MainView: View {
    @State private var authorizationStatus = PHPhotoLibrary.authorizationStatus()
    var body: some View {
       
        TabView(){
            TodayView().tabItem {
                Image(systemName: "doc.text.image.fill")
                Text("today")
            }
            
            PhotoView().tabItem {
                Image(systemName: "photo.on.rectangle.angled")
                Text("photo")
            }.background(.mySurface)
            
            TodoView().tabItem {
                Image(systemName: "checklist")
                Text("todo")
            }.background(.mySurface)
        }.accentColor(.myTertiary)
        
    }
    
    
}

#Preview {
    MainView()
}
