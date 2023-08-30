//
//  ViewController.swift
//  MiniTimerApp
//
//  Created by Barkın Süngü on 29.08.2023.
//

import UIKit
import AVFoundation

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
        button.setTitle("Play", for: .normal)
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
    
    // Timer properties
        var timer: Timer?
        var isTimerRunning = false
        var remainingTimeInSeconds: TimeInterval = 0

    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
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
        if isTimerRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    @objc func setResetButtonTapped(){
        resetTimer()
    }
    
    func startTimer() {
        if !isTimerRunning {
            if remainingTimeInSeconds == 0{
                remainingTimeInSeconds = timePicker.countDownDuration
            }
            updateTimerLabel()
            playPauseButton.setTitle("Pause", for: .normal)
            isTimerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    func pauseTimer() {
        if isTimerRunning {
            timer?.invalidate()
            playPauseButton.setTitle("Play", for: .normal)
            isTimerRunning = false
        }
    }
        
    @objc func updateTimer() {
        if remainingTimeInSeconds > 0 {
            remainingTimeInSeconds -= 1
            updateTimerLabel()
        } else {
            pauseTimer()
            showTimerElapsedAlert()
            playSound()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        isTimerRunning = false
        remainingTimeInSeconds = 0
        updateTimerLabel()
        playPauseButton.setTitle("Play", for: .normal)
    }
    
    func updateTimerLabel() {
        let minutes = Int(remainingTimeInSeconds) / 60
        let seconds = Int(remainingTimeInSeconds) % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func showTimerElapsedAlert() {
        let alert = UIAlertController(title: "Timer has elapsed!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.stopAlarm()
            }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
        
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "wav") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopAlarm() {
        player?.stop()
    }
}

