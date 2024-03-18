//
//  PhotoView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/1.
//

import SwiftUI

struct PhotoView: View {
    @StateObject private var orientationManager = OrientationManager()
    @Environment(\.horizontalSizeClass)  private var sizeClass
    var body: some View {
        
        @State var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: columns)
        
        
        NavigationStack{
            ScrollView{
                TopBarView(name: "Photo")
                LazyVGrid(columns: gridItem, content: {
                    ForEach(1...10, id: \.self) {index in
                        NavigationLink(destination: PhotoDetailView()){
                            DetailView(rowCount:columns)
                        }
                    }
                }).scrollTargetLayout().animation(.default, value: columns) // todo 换一个动画
            }.scrollTargetBehavior(.viewAligned) .scrollIndicators(.hidden).safeAreaPadding(.horizontal)
        }.accentColor(.myPrimary)
        
    }
    
    private var columns: Int {
        return  Device.deviceType == .iphone ? 2: (orientationManager.deviceOrientation == .landscapeLeft || orientationManager.deviceOrientation == .landscapeRight) ? 4:3
    }
}

struct DetailView:View {
    @State var rowCount :Int=2;
    var body: some View {
        VStack(alignment: .leading){
            GeometryReader{ geometry in
                AsyncImage(url: URL(string: "https://ts1.cn.mm.bing.net/th/id/R-C.466bb61cd7cf4e8b7d9cdf645add1d6e?rik=YRZKRLNWLutoZA&riu=http%3a%2f%2f222.186.12.239%3a10010%2fwmxs_161205%2f002.jpg&ehk=WEy01YhyfNzzQNe1oIqxwgbTnzY7dMfmZZHkqpZB5WI%3d&risl=&pid=ImgRaw&r=0")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width:geometry.size.width,height: geometry.size.height)
                        .clipped()
                } placeholder: {
                    Color.pink.opacity(0.1)
                }
                
                //                VStack(alignment: .leading){
                //                    Text("这个是简介 11111").foregroundStyle(.myTitle)
                //                }
            }
        }.aspectRatio(3/4, contentMode: .fit)
            .frame(width: .infinity).background(.regularMaterial).cornerRadius(8)
        
    }
}

#Preview {
    PhotoView()
}

















