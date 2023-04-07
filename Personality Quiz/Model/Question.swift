//
//  Question.swift
//  Personality Quiz
//
//  Created by Maryna Bolotska on 05/04/23.
//

import Foundation


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}


extension Question {
    static func getQuestions() -> [Question] {
        return [
        Question(
            text: "Your favourite food",
            type: .single,
            answers: [
                Answer(text: "Meat", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Bread", type: .chiken),
                Answer(text: "Insects", type: .frog)
            ]
        ),
        Question(
            text: "What do you like more?",
            type: .multiple,
            answers: [
                Answer(text: "Travel", type: .dog),
                Answer(text: "Eat", type: .cat),
                Answer(text: "Slep", type: .chiken),
                Answer(text: "Walk", type: .frog)
            ]
        ),
        Question(
            text: "Do you like to sleep?",
            type: .ranged,
            answers: [
                Answer(text: "Yes", type: .dog),
                Answer(text: "Adore", type: .cat),
                Answer(text: "No", type: .chiken),
                Answer(text: "Sometimes", type: .frog)
            ]
        )
        ]
    }
}
