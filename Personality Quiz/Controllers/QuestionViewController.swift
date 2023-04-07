//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Maryna Bolotska on 05/04/23.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    
    // MARK: - IBOutletes
   
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitch: [UISwitch]!
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // MARK: - Private properties
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    

   
    
    // MARK: - IBActions
    
    @IBAction func singleAnswerPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleResponseButton(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        for (multipleSwitc, answer) in zip(multipleSwitch, currentAnswers) {
            if multipleSwitc.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    
    
    @IBAction func rangedAnswersButton() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
// MARK: - Private Methods
    
    
    // Update user interface
    private func updateUI() {
        // Hide everything
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question label
        questionLabel.text = currentQuestion.text
        
        // Set progress for question progress view
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Question # \(questionIndex + 1) from \(questions.count)"
        
        let currentAnswers = currentQuestion.answers
        
        // Show stack view due to question type
        
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
        
        
    }

    
    
    /// Setup singe stack view
    ///
    /// - Parameter answers: - array with answers
    ///
    /// Description of method
    private func updateSingleStackView(using answers: [Answer]) {
        // Show stack view
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func updateMultipleStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func updateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabel.first?.text = answers.first?.text
        rangedLabel.last?.text = answers.last?.text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else { return }
        let resultVC = segue.destination as! ResultViewController
        resultVC.responses = answersChosen
    }

}
