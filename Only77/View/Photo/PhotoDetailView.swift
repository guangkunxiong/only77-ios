//
//  PhotoDetailView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/3.
//

import SwiftUI

struct PhotoDetailView: View {
    var body: some View {
        ScrollView{
            VStack{
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ImgView()
                        ImgView()
                    }.scrollTargetLayout()
                }.scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
            }
            
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden).ignoresSafeArea()
    }
}

struct ImgView:View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        
        ZStack(){
            GeometryReader{ geometry in
                AsyncImage(url: URL(string: "https://ts1.cn.mm.bing.net/th/id/R-C.466bb61cd7cf4e8b7d9cdf645add1d6e?rik=YRZKRLNWLutoZA&riu=http%3a%2f%2f222.186.12.239%3a10010%2fwmxs_161205%2f002.jpg&ehk=WEy01YhyfNzzQNe1oIqxwgbTnzY7dMfmZZHkqpZB5WI%3d&risl=&pid=ImgRaw&r=0")) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width,height: geometry.size.height).clipped()
                } placeholder: {
                    Color.pink.opacity(0.1)
                }
            }
        }.aspectRatio(heroRatio, contentMode: .fit)
            .containerRelativeFrame(
                [.horizontal], count: columns, spacing: hSpacing
            )
            .clipShape(.rect())
            .scrollTransition(axis: .horizontal) { content, phase in
                content
                    .scaleEffect(
                        x: phase.isIdentity ? 1.0 : 0.98,
                        y: phase.isIdentity ? 1.0 : 0.95)
            }
        
    }
    
    private var columns: Int {
        sizeClass == .compact ? 1 : regularCount
    }
    var regularCount: Int {
        2
    }
    var hSpacing: CGFloat {
        10.0
    }
    var heroRatio: CGFloat {
        3.0 / 4.3
    }
    var stackPadding: CGFloat {
        10.0
    }
}

#Preview {
    PhotoDetailView()
}
