//
//  TadyView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/7.
//

import SwiftUI
import DominantColor


struct TodayView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    private var tadayCards:[TodayCard] = [
        TodayCard(name: "今日图片", photo: "Image333", title: "今日图片", title2: "快来看看今天的图片吧"),
        TodayCard(name: "纪念日图片", photo: "Image222", title: "一百天纪念日图片", title2: "一百天纪念日图片的标题"),
        
    ]
    
    @State var currentItem: TodayCard?
    @State var showDetailPage: Bool = false
    @Namespace var animation
    @State var animationView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        @State var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: columns)
        
        let image = UIImage(named: "Image222")!
        let dominantColors = image.dominantColors()
        let uiColor = dominantColors.first ?? UIColor.white
        let bgColor = Color(uiColor)
        var hSpacing: CGFloat {
            10.0
        }
        
        ScrollView(.vertical, showsIndicators: false) {
            TopBarView(name: "Today")
            
            LazyVGrid(columns:gridItem){
                
                ForEach(tadayCards){ item in
                    Button{
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            showDetailPage = true
                            currentItem = item
                        }
                    }label: {
                        HItemView(today: item,columns: columns) .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.98)
                    }.buttonStyle(TodayButtonStyle()) .scaleEffect(showDetailPage ? 1 : 0.98)
                }
                
                TotoTabView(bgColor: bgColor.opacity(0.8)).padding(.top)
                
            }
        }.overlay{
            if let currentItem = currentItem, showDetailPage {
                TodayPhotoView(currentItem:currentItem,showDetailPage:$showDetailPage,animationView:$animationView,animateContent:$animateContent,scrollOffset:$scrollOffset)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .safeAreaPadding(.horizontal) .scrollIndicators(.hidden)
        
    }
    private var columns: Int {
        sizeClass == .compact ? 1 : 2
    }
    
    @ViewBuilder
    func HItemView(today: TodayCard,columns:Int) -> some View {
        
        var hSpacing: CGFloat {
            10.0
        }
        var heroRatio: CGFloat {
            3.0 / 4.0
        }
        var stackPadding: CGFloat {
            10.0
        }
        let image = UIImage(named:today.photo)!
        let dominantColors = image.dominantColors()
        let uiColor = dominantColors.first ?? UIColor.white
        let bgColor = Color(uiColor)
        
        ZStack(){
            GeometryReader{ geometry in
                Image(today.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,height: geometry.size.height).clipped()
                
                VStack{
                    Spacer()
                    HStack(){
                        VStack(alignment:.leading ){
                            Text(today.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.primary)
                            Text(today.title2).font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        Button{
                            // todo
                        }label: {
                            Image(systemName: "icloud.and.arrow.up") .font(.title3).foregroundColor(.white)
                        }
                        
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding().background(Color(bgColor))
                }
            }
        }.aspectRatio(heroRatio, contentMode: .fit)
            .containerRelativeFrame(
                [.horizontal], count: columns, spacing: hSpacing
            )
            .clipShape(.rect(cornerRadius: 20.0))
            .matchedGeometryEffect(id: today.id, in: animation)
    }
}


struct TotoTabView:View {
    @State var bgColor :Color
    @State private var selection = Set<String>()
    let todoItems: [ToDoItem] = [ToDoItem(name: "AAAA"),ToDoItem(name: "AAAA"),ToDoItem(name: "AAAA")]
    
    var body: some View {
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
            }
        } .listStyle(.automatic).listRowSpacing(5).frame(minWidth: 0,maxWidth: .infinity,minHeight: 200,maxHeight:200).background(.myTertiary.opacity(0.5)).scrollContentBackground(.hidden).clipShape(.rect(cornerRadius: 20.0))
    }
}

struct ToDoListRow: View {
    
    @ObservedObject var todoItem: ToDoItem
    
    var body: some View {
        Toggle(isOn: self.$todoItem.isComplete) {
            HStack {
                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isComplete, color: .black)
                    .bold()
                    .animation(.default)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(self.color(for: self.todoItem.priority))
            }
        }.toggleStyle(CheckboxStyle())
    }
    
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .high: return .primaryContainer
        case .normal: return .myTertiary
        case .low: return .mySurface
        }
    }
}
#Preview {
    TodayView()
}
