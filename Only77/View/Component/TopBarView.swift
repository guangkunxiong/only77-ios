//
//  TopBarView.swift
//  Only77
//
//  Created by yukun xie on 2024/2/7.
//

import SwiftUI

struct TopBarView:View {
    @State var name:String
    var body: some View {
        HStack{
            Text(name)
                .font(.largeTitle)
                .fontWeight(.heavy)
//            Text(currentDate())
            Spacer()
            // todo 头像
            //                   AvatarView(image: "profile", width: 40, height: 40)
        }.frame(width: .infinity).safeAreaPadding(.horizontal)
    }
    func currentDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat="M月d日"
        formatter.locale=Locale(identifier: "zh-CN")
        return formatter.string(from:Date())
    }
}

#Preview {
    TopBarView(name: "Today")
}
