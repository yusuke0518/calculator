//
//  ViewModel.swift
//  calculator
//
//  Created by y-hosaka on 2019/08/22.
//  Copyright © 2019 testie. All rights reserved.
//

import Expression

class ViewModel {
    let errorMessage = "式を正しく入力してください"
    let cannotFactorization = "素因数分解できません"
    
    
    func formatFormula(_ formula: String) -> String {
        // 入力された整数には`.0`を追加して小数として評価する
        // また`÷`を`/`に、`×`を`*`に置換する
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return errorMessage
        }
    }
    
    func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
    
    func primeFactorizaiton(_ text : String) -> String {
        if text.isNumber() != true { return cannotFactorization }
        let num = Double(text)!
        var ans = ""
        let to = Int(sqrt(num)+1)
        var t = Int(num)
        for i in 2...to {
            if t % i == 0 {
                var cnt = 0
                repeat{
                    cnt+=1
                    t/=i
                } while t % i == 0
                
                if cnt == 1 {
                    ans = ans + "✕" + String(i)
                }
                else {
                    ans = ans + "✕" + String(i) + "^" + String(cnt)
                }
            }
        }
        
        if t > to && t != 1 {
            ans = ans + "✕" + String(t)
        }
        return String(ans[ans.index(after: ans.startIndex)..<ans.endIndex])
        
    }
    
    
}

extension String {
    func isNumber() -> Bool {
        let pattern = "^[\\d]+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: count))
        return matches.count > 0
    }
}
