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
    
    let viewModel = ViewModel()
    var taxIncluded: Bool?
    
    override func viewDidLoad() {
        viewSettings()
        super.viewDidLoad()
    }
    
    func initModel(){
        formulaLabel.text = ""
        taxIncluded = false
    }
    
    func viewSettings(){
        initModel()
        formulaLabel.layer.borderColor = UIColor.black.cgColor
        formulaLabel.layer.borderWidth = 3
    }
    
    @IBAction func inputFormula(_ sender: Any) {
        if formulaLabel.text == viewModel.errorMessage || formulaLabel.text == viewModel.cannotFactorization {
            formulaLabel.text = ""
        }
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = (sender as AnyObject).titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearFormula(_ sender: Any) {
        initModel()
    }
    
    @IBAction func calculateFormula(_ sender: Any) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = viewModel.formatFormula(formulaText)
        formulaLabel.text = viewModel.evalFormula(formula)
    }
    
    @IBAction func includeTax(_ sender: Any) {
        if taxIncluded == true { return }
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = viewModel.formatFormula(formulaText)
        formulaLabel.text = viewModel.evalFormula(formula)
        if formulaLabel.text != viewModel.errorMessage{
            let num = Double(formulaLabel.text!)!
            formulaLabel.text = viewModel.formatFormula(String(num*1.08))
            taxIncluded = true
        }
    }
    
    @IBAction func excludeTax(_ sender: Any) {
        if taxIncluded != true { return }
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = viewModel.formatFormula(formulaText)
        formulaLabel.text = viewModel.evalFormula(formula)
        if formulaLabel.text != viewModel.errorMessage{
            let num = Double(formulaLabel.text!)!
            formulaLabel.text = viewModel.formatFormula(String(num/1.08))
            taxIncluded = false
        }
    }
    
    @IBAction func primeFactorization(_ sender: Any) {
        formulaLabel.text = ViewModel().primeFactorizaiton(formulaLabel.text!)
    }
    
}

