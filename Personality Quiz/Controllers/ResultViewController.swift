//
//  ResultViewController.swift
//  Personality Quiz
//
//  Created by Maryna Bolotska on 05/04/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultDefenition: UILabel!
    
    // MARK: - Public Properties
    

    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateResult()
        
    }
 

    
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = responses.map { $0.type }
        
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        
        guard let mostFrequentAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequentAnimal)
    }
    
    private func updateUI(with animal: AnimalType) {
        resultLabel.text = "You are \(animal.rawValue)"
        resultDefenition.text = "\(animal.definition)"
    }
    

}
