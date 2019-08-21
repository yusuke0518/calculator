//
//  ViewController.swift
//  calculator
//
//  Created by yamlab on 2019/08/22.
//  Copyright © 2019 testie. All rights reserved.
//

import UIKit
import Expression

class ViewContrller: UIViewController {
    
    
    @IBOutlet weak var formulaLabel: UILabel!
    
    override func viewDidLoad() {
        viewSettings()
        super.viewDidLoad()
    }
    
    func viewSettings(){
        formulaLabel.text = ""
        formulaLabel.layer.borderColor = UIColor.black.cgColor
        formulaLabel.layer.borderWidth = 3
    }
    
    @IBAction func inputFormula(_ sender: Any) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = (sender as AnyObject).titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func calculateAnswer(_ sender: Any) {
        formulaLabel.text = ""
    }
    
    @IBAction func clearFormula(_ sender: Any) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        formulaLabel.text = evalFormula(formula)
    }
    
    private func formatFormula(_ formula: String) -> String {
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
    
    private func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
    
    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
    
}

