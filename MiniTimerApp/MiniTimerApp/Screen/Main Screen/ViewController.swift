//
//  ViewController.swift
//  MiniTimerApp
//
//  Created by Barkın Süngü on 29.08.2023.
//

import UIKit

class ViewController: UIViewController {
    // UI elements
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.setValue(UIColor.black, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .black
        label.layer.borderWidth = 3.0
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play/Pause", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let setResetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set/Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(setResetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(timePicker)
        view.addSubview(timerLabel)
        view.addSubview(playPauseButton)
        view.addSubview(setResetButton)
        
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            timePicker.widthAnchor.constraint(equalToConstant: 200),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            timerLabel.widthAnchor.constraint(equalToConstant: 150),
            
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            playPauseButton.widthAnchor.constraint(equalToConstant: 150),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),

            
            setResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setResetButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 20),
            setResetButton.widthAnchor.constraint(equalToConstant: 150),
            setResetButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    
    @objc func playPauseButtonTapped(){
        
    }
    
    @objc func setResetButtonTapped(){
        
    }


}

