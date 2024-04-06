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
    
    @State var today = TodayCard(name: "今日图片", photos: [UIImageColor(Image: UIImage(named:"Image222")!,Color:UIColor(hex: "#E3BEC6"))], title: "今日图片", title2: "快来看看今天的图片吧")
    
    @State private var todoItems: [ToDoItem] = [ToDoItem(name: "AAAA"),ToDoItem(name: "AAAA"),ToDoItem(name: "AAAA")]
    
    @State var todayImages=[UIImageColor]()
    @State private var selection = 0
    
    @State var currentItem: TodayCard?
    @State var showDetailPage: Bool = false
    @Namespace var animation
    @State var animationView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    @State var bgColor: Color=Color(UIColor.white)
    
    var body: some View {
        @State var gridItem: [GridItem] = Array(repeating: .init(.flexible()), count: columns)
        
        var hSpacing: CGFloat { 10.0}
        
        ScrollView(.vertical, showsIndicators: false) {
            TopBarView(name: "Today")
            
            LazyVGrid(columns:gridItem){
                Button{
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        currentItem = today
                    }
                }label: {
                    HItemView(todays: today,columns: columns) .scaleEffect(currentItem?.id == today.id && showDetailPage ? 1 : 0.99)
                }.buttonStyle(TodayButtonStyle()) .scaleEffect(showDetailPage ? 1 : 0.99)
                
                TotoView().padding(.top)
            }.task{
                todayImages = await GetDayImgae()
                if  todayImages.count>0 {
                    today.photos=todayImages
                }
                bgColor = Color(uiColor: today.photos[0].Color)
            }
        }
        .safeAreaPadding(.horizontal) .scrollIndicators(.hidden)
    }
    
    private var columns: Int {
        sizeClass == .compact ? 1 : 2
    }
    
    @ViewBuilder
    func HItemView(todays: TodayCard,columns:Int) -> some View {
        
        var hSpacing: CGFloat {
            10.0
        }
        var heroRatio: CGFloat {
            3.0 / 4.0
        }
        var stackPadding: CGFloat {
            10.0
        }
        
        ZStack(){
            GeometryReader{ geometry in
                VStack{
                    TabView(selection: $selection) {
                        ForEach(Array(today.photos.enumerated()), id: \.offset) { index, image in
                            Image(uiImage: image.Image)
                                .resizable()
                                .scaledToFill()
                                .frame(width:geometry.size.width,height: geometry.size.height)
                                .clipped()
                                .tag(index)
                        }
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .onChange(of: selection) { oldValue, newValue in
                        bgColor = Color(uiColor: today.photos[selection].Color)
                    }
                }
                
                VStack{
                    Spacer()
                    HStack(){
                        VStack(alignment:.leading ){
                            Text(today.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.primary)
                            Text(today.title2).font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            NavigationLink(destination: PhtotoUpdateView()){
                                Image(systemName: "icloud.and.arrow.up") .font(.title3).foregroundColor(.white)
                            }
                            
                        }
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding().background(bgColor).animation(.easeIn(duration: 1), value: bgColor)
                }
            }
        }.aspectRatio(heroRatio, contentMode: .fit)
            .containerRelativeFrame(
                [.horizontal], count: columns, spacing: hSpacing
            )
            .clipShape(.rect(cornerRadius: 20.0))
            .matchedGeometryEffect(id: today.id, in: animation)
    }
    
    @ViewBuilder
    func TotoView()-> some View {
        @State  var selection = Set<String>()
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
            }
        } .listStyle(.automatic).listRowSpacing(5).frame(minWidth: 0,maxWidth: .infinity,minHeight: 200,maxHeight:200).background(bgColor).animation(.easeIn(duration: 1), value: bgColor).scrollContentBackground(.hidden).clipShape(.rect(cornerRadius: 20.0))
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
