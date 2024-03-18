//
//  TodayPhotoView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/15.
//

import SwiftUI

struct TodayPhotoView: View {
    @State var currentItem:TodayCard?
    @Binding var showDetailPage:Bool
    @Binding var animationView: Bool
    @Binding var animateContent: Bool
    @Binding var scrollOffset:CGFloat
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                Image(.image222)
                    .resizable()
                    .frame(width: .infinity)
                    .scaledToFill().clipped()
                    .scaleEffect(animationView ? 1 : 0.93)
                
                VStack(spacing: 15) {
                    Divider()
                }
                .foregroundColor(.white)
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ?  1 : 0)
                .scaleEffect(animationView ? 1 : 0, anchor: .top)
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
                    currentItem = nil
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
