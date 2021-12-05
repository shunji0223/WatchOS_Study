//
//  DataCollection.swift
//  hakkasonn WatchKit Extension
//
//  Created by 朱駿璽 on 2021/12/04.
//

import WatchKit
import HealthKit

struct DataCollection {
    
    init() {
        
    }
    
    var healthStore = HKHealthStore()
    // アクセス許可が欲しいデータタイプを指定
    var allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])  //今回は歩数のみ
    
    var type = HKObjectType.quantityType(forIdentifier: .stepCount)!  // allTypeとは別にtypeを定義
    
    var calendar = Calendar.current  // カレンダーを取得
    
    func Check() -> String {
        var labelText: String = ""
        if HKHealthStore.isHealthDataAvailable() {
            labelText = "HealthKit Available"
        }else{
            labelText = "Unavailable"
        }
        return labelText
    }
    
    func GetStep() -> String {
        var labelText: String = ""
        if HKHealthStore.isHealthDataAvailable() {
            let readTypes = Set([
                HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount )!
            ])
            
            healthStore.requestAuthorization(toShare: [], read: readTypes, completion: { success, error in
                
                if success == false {
                    print("データにアクセスできません")
                    return
                }
                let date = Date()  // 今日の日付を取得
                let yesterday = self.calendar.date(byAdding: .day, value: -1, to: date)  //"昨日"は上で定義したカレンダーを使って計算する
                // 歩数を取得
                let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: date)
                let query = HKStatisticsQuery(quantityType: self.type, quantitySamplePredicate: predicate, options:.cumulativeSum){query, result, error in
                    
                    guard error == nil else { print("error=\(String(describing: error))"); return }
                    
                    let tmpResults = result?.sumQuantity() as Any
                    // 取得したデータを格納
                    var step = 0.0  // 結果を格納するための変数
                    print("step is \(tmpResults)")
                    step = (tmpResults as AnyObject).doubleValue(for: HKUnit.count())
                    labelText = String(step)
                    
                }
                healthStore.execute(query)
            })
        }
        return labelText
    }
    
}
