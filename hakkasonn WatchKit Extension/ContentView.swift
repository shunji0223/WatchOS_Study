//
//  ContentView.swift
//  hakkasonn WatchKit Extension
//
//  Created by 朱駿璽 on 2021/12/02.
//

import SwiftUI
import WatchKit
import HealthKit

struct ContentView: View {
    @State var name: String = ""
    /// データベースよりデータを取得
    /*
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \AvatarEntity.userName, ascending: true)],
            animation: .default)
    private var avatar: FetchedResults<AvatarEntity>
    */
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    HStack{
                        Text("情報取得：").foregroundColor(.white)
                        TextField("あなたの名前", text: $name).foregroundColor(.white)
                    }
                    Button("get"){
                        self.name = DataCollection().GetStepSync()
                    }
                }
            }
            .background(
            Image("mazda")
                .resizable()
                .frame(width: WKInterfaceDevice.current().screenBounds.size.width, height: WKInterfaceDevice.current().screenBounds.size.height, alignment: .center))
            .navigationTitle(Text("Mazda"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//button style
struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        MyButton(configuration:configuration)
    }
    
    struct MyButton: View {
        @Environment(\.isEnabled) var isEnabled
        let configuration: MyButtonStyle.Configuration
        var body: some View {
            configuration.label
                .foregroundColor(isEnabled ? .white : .gray)
                .opacity(configuration.isPressed ? 0.2 : 1.0)
                .padding(15)
                .background(isEnabled ? Color.black.opacity(0.4) : Color.gray)
                .cornerRadius(10)
        }
    }
}

