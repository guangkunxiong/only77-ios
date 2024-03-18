//
//  Home.swift
//  AppStoreShowDetailList
//
//  Created by 张亚飞 on 2022/4/7.
//

import SwiftUI

struct Home: View {
    
    @State var currentItem: Today?
    @State var showDetailPage: Bool = false
    
    @Namespace var animation
    
    @State var animationView: Bool = false
    @State var animateContent: Bool = false
    
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 30) {
                ForEach(todayItenms) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            
                            currentItem = item
                            showDetailPage = true
                        }
                        
                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
                }
            }
            .padding(.vertical)
        }
        .overlay{
            
            if let currentItem = currentItem, showDetailPage {
                
                DetailView(item:currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
//        .background(alignment: .top) {
//            
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .fill(Color("BG"))
//                .frame(height: animationView ? nil : 350, alignment: .top)
//                .scaleEffect(animationView ? 1 : 0.93)
//                .opacity(animationView ? 1 : 0)
//                .ignoresSafeArea()
//        }
    }
    
    //Mark CardView
    @ViewBuilder
    func CardView(item: Today) -> some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            ZStack(alignment: .topLeading) {
                
                //banner img
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    Image(item.artWork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 400)
                LinearGradient(colors: [
                    
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
                .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)
                .padding()
                .offset(y: currentItem?.id == item.id && animationView ? safeArea().top : 0)
                
            }
            
            HStack(spacing: 12) {
                
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(item.appName.uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                    Text(item.appDescription.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
//                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    
                } label: {
                    
                    Text("GET")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background{
                            
                            Capsule()
                                .fill(.ultraThinMaterial)
                        }
                }

            }
            .padding([.horizontal, .bottom])
        }
        .background {
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("BG"))
        }
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    @ViewBuilder
    func DetailView(item: Today) -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                CardView(item: item)
                    .scaleEffect(animationView ? 1 : 0.93)
                
                VStack(spacing: 15) {
                    
                    Divider()
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            
                            Text("Share Story")
                        } icon: {
                            
                            Image(systemName: "square.and.arrow.up.fill")
                        }
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.ultraThinMaterial)
                        }

                    }

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

#Preview {
    Home()
}



// mark scaledButton Style
struct ScaledButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


extension View {
    
    func safeArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            
            return .zero
        }
          
        return safeArea
    }
    
    func offset(offset: Binding<CGFloat>) -> some View {
        
        return self.overlay{
            
            GeometryReader { proxy in
                
                let minY = proxy.frame(in: .named("SCROLL")).minY
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
            }
            .onPreferenceChange(OffsetKey.self) { value in
                
                offset.wrappedValue = value
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
}

struct Today: Identifiable {
    
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artWork: String
}

var todayItenms: [Today] = [

    Today(appName: "LEGO Brawle", appDescription: "Battle with friends online", appLogo: "Logo1", bannerTitle: "Smash your rivals in LEGO Brawls", platformTitle: "Apple Arcade", artWork: "Post1"),
    Today(appName: "Forza Horizon", appDescription: "Racing Game", appLogo: "Logo2", bannerTitle: "Your're in change of the Horizon", platformTitle: "Apple Arcade", artWork: "Post2")
]

