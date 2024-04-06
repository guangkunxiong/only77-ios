//
//  TodayPhotoView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/15.
//

import SwiftUI

struct TodayPhotoView: View {
    @StateObject private var orientationManager = OrientationManager()
    @Environment(\.horizontalSizeClass)  private var sizeClass
    
    @State var images:[UIImage]
    @Binding var showDetailPage:Bool
    @Binding var animationView: Bool
    @Binding var animateContent: Bool
    @Binding var scrollOffset:CGFloat
    
    private var columns: Int {
        return  Device.deviceType == .iphone ? 2: (orientationManager.deviceOrientation == .landscapeLeft || orientationManager.deviceOrientation == .landscapeRight) ? 4:3
    }
    
    var body: some View {
        @State var gridItem: [GridItem] = Array(repeating: .init(.flexible(),spacing: 0), count: columns)

        var hSpacing: CGFloat {
            10.0
        }
        var heroRatio: CGFloat {
            3.0 / 4.0
        }
        var stackPadding: CGFloat {
            10.0
        }
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                LazyVGrid(columns: gridItem, spacing: 0) {
                    ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill().clipped()
                    }
                }
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animationView = false
                    animateContent = false
                }
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, safeArea().top)
            .opacity(animationView ? 1 : 0)
            
        })
        .onAppear{
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7)) {
                animationView = true
            }
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                animateContent = true
            }
        }
        .transition(.identity)
    }
    
}

#Preview {
    TodayPhotoView(images: [UIImage(named:"Image222")!,UIImage(named:"Image222")!,UIImage(named:"Image222")!,UIImage(named:"Image222")!,UIImage(named:"Image222")!], showDetailPage: Binding.constant(true), animationView:  Binding.constant(true), animateContent:  Binding.constant(true), scrollOffset: Binding.constant(10))
}
