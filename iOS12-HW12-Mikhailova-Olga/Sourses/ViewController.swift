//
//  ViewController.swift
//  iOS12-HW12-Mikhailova-Olga
//
//  Created by mbpro2.0/16/512 on 19.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Constants
    
    var isWorkTime = true
    var isStarted = false
    var timer: Timer?
    let workTime: Float = 25
    let restTime: Float = 10
    var timeLeft: Float = 0
    
    //MARK: - Outlets UI
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var switchOnOffButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var progressBar: CircularProgress = {
       let progressBar = CircularProgress(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressBar.trackColor = .gray
        progressBar.progressColor = .green
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupView()
        setupHierarchy()
        setupLayout()
       
        
    }
    
    //MARK: - Setups
    private func setupView(){
        
    }
    
    private func setupHierarchy() {
        view.addSubview(progressBar)
        view.addSubview(timeLabel)
        view.addSubview(switchOnOffButton)
        
    }
    
    private func setupLayout() {
        progressBar.center = view.center
    
        NSLayoutConstraint.activate([
//            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            switchOnOffButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            switchOnOffButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        
        ])
    }
    
    //MARK: func
    
    func checkStatusButton() {
        if isStarted {
            timer?.invalidate()
            timer = nil
            isStarted = false
            
            switchOnOffButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        } else {
            isStarted = true
            startTimer()
            
            switchOnOffButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            
        }
        setupProgressBar()
    }
    
    func startTimer() {
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.checkStatusTimer()
        })
    }
    
    func setupProgressBar() {
        let start = 1 - timeLeft / (isWorkTime ? workTime : restTime)
        if !isStarted {
            progressBar.setProgressWithAnimation(duration: 0, value: Float(start))
        } else {
            progressBar.setProgressWithAnimation(duration: TimeInterval(timeLeft), start: start, finish: 1)
        }
    }
    
    
    func checkStatusTimer() {
        if timeLeft == 0 {
            if isWorkTime {
                timeLeft = restTime
                progressBar.progressColor = .systemGreen
            } else {
                timeLeft = workTime
                progressBar.progressColor = .systemRed
            }
            progressBar.setProgressWithAnimation(duration: TimeInterval(timeLeft), value: 1)
       
            isWorkTime.toggle()
        }
        
        self.timeLeft -= 1
       // let finish = 1 - timeLeft / (isWorkTime ? workTime : restTime)
        timeLabel.text = "\(timeLeft)"
        
    }
    
    
    //MARK: - Actions
    
    @objc private func pressButton () {
        checkStatusButton()
        
    }
}
