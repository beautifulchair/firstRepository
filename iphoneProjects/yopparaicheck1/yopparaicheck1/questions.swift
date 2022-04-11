//
//  questions.swift
//  yopparaicheck1
//
//  Created by 目黒丈一郎 on 2021/09/29.
//

import UIKit

let questionLabelWidthRate = CGFloat(0.9)
let questionLabelHeightRate = CGFloat(0.7)
let questionSentenceHeightRate = CGFloat(0.45)
let questionSentenceWidthRate = CGFloat(0.95)
let questionSentenceYRate = CGFloat(0.25)
let questionChoicesHeightRate = CGFloat(0.4)
let questionChoicesWidthRate = CGFloat(0.7)
let questionChoicesYRate = CGFloat(0.8)

class Question{
    let buttonOpen: UIButton
    let questionSentence: String
    let choices: [String]
    let answer: Int
    let questionLabel: UILabel
    init(sentence: String, choices: [String], answer: Int){
        self.questionSentence = sentence
        self.choices = choices
        self.answer = answer
        self.questionLabel = UILabel()
        self.buttonOpen = UIButton()
    }
    @objc func check(sender: UIButton) -> Bool{
        if self.choices.firstIndex(of: sender.currentTitle!) == self.answer{
            print("seikai")
            questionLabel.removeAllSubviews()
            buttonOpen.set(questionLabel, widthRate: 0.7, heightRate: 0.1, xRate: 0.5, yRate: 0.5)
            buttonOpen.setTitle("open LINE", for: .normal)
            buttonOpen.backgroundColor = .green
            buttonOpen.addTarget(self, action: #selector(openLine), for: .touchDown)
            return true
        }else{
            print("matigai")
            questionLabel.isHidden = true
            return false
        }
    }
    @objc func back(){
        questionLabel.isHighlighted = true
    }
    @objc func openLine(){
        if UIApplication.shared.canOpenURL(lineurl!){
            UIApplication.shared.open(lineurl!, options: [:], completionHandler: nil)
        }
    }
    func visualize(_ parentView: UIView){
        let questionSentenceLabel =  UILabel()
        let choicesListLabel =  UILabel()
        let choiceButton1 = UIButton()
        let choiceButton2 = UIButton()
        let choiceButton3 = UIButton()
        let choiceButtons = [choiceButton1, choiceButton2, choiceButton3]
        let submitButton = UIButton()
        questionLabel.set(parentView, widthRate: questionLabelWidthRate, heightRate: questionLabelHeightRate, xRate: 0.5, yRate: 0.5)
        questionLabel.backgroundColor = .gray
        questionLabel.isUserInteractionEnabled = true
        questionLabel.backgroundColor = .systemGray4
        questionSentenceLabel.set(questionLabel, widthRate: questionSentenceWidthRate, heightRate: questionSentenceHeightRate, xRate: 0.5, yRate: questionSentenceYRate)
        questionSentenceLabel.text = self.questionSentence
        questionSentenceLabel.textAlignment = .center
        questionSentenceLabel.backgroundColor = .white
        questionSentenceLabel.textColor = .blue
        choicesListLabel.set(questionLabel, widthRate: questionChoicesWidthRate, heightRate: questionChoicesHeightRate, xRate: 0.5, yRate: questionChoicesYRate)
        choicesListLabel.backgroundColor = .red
        choicesListLabel.isUserInteractionEnabled = true
        choiceButton1.setTitle(self.choices[0], for: .normal)
        choiceButton2.setTitle(self.choices[1], for: .normal)
        choiceButton3.setTitle(self.choices[2], for: .normal)
        choiceButton1.set(choicesListLabel, widthRate: 0.95, heightRate: 0.3, xRate: 0.5, yRate: 0.16)
        choiceButton2.set(choicesListLabel, widthRate: 0.95, heightRate: 0.3, xRate: 0.5, yRate: 0.49)
        choiceButton3.set(choicesListLabel, widthRate: 0.95, heightRate: 0.3, xRate: 0.5, yRate: 0.82)
        choiceButton1.backgroundColor = .systemGray3
        choiceButton2.backgroundColor = .systemGray4
        choiceButton3.backgroundColor = .systemGray3
        choiceButtons.forEach{$0.setTitleColor(.black, for: .normal)}
        choiceButtons.forEach{$0.addTarget(self, action: #selector(check(sender:)), for: .touchUpInside)}
        submitButton.set(questionLabel, widthRate: 0.7, heightRate: 0.1, xRate: 0.5, yRate: 1.1)
        //submitButton.backgroundColor = .blue
        //submitButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
}

let question1 = Question(sentence: "kyou no hizuke ha?", choices: ["Friday", "2021/9/29", "2020/9/29"], answer: 1)
let question2 = Question(sentence: "2 * 5 * 8 + 3 = ?", choices: ["80", "18", "83"], answer: 2)
let question3 = Question(sentence: "17 no nizyou ha?", choices: ["300 - 11", "189", "34"], answer: 0)

let questionList = [question1, question2, question3]
