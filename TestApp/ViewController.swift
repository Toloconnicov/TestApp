//
//  ViewController.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 4/11/19.
//  Copyright © 2019 Endava. All rights reserved.
//

// Apple's Speech framework

import UIKit
import Speech

class ViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var transcriptionOutputLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    var speechRecognizer = SFSpeechRecognizer()
    let audioEngine = AVAudioEngine()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var recording = 0

    var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerLabel.text = "Welcome"
        centerLabel.font.withSize(40)
        self.transcriptionOutputLabel.text = "Try to record a command"

        SFSpeechRecognizer.requestAuthorization {
            (authStatus) in
                switch authStatus {
                case .authorized:
                    break
                case .denied:
                    break
                case .restricted:
                    break
                case .notDetermined:
                    break
                }
        }
    }

    
    fileprivate func startRecording() throws {
        if !speechRecognizer!.isAvailable {
            showErrorAlert(title: "Recorder Error", message: "Not available right now")
            return
        }
        
        recording = 1
        recordButton.setImage(UIImage(named: "stopButtonImage.png"), for: .normal)
        mostRecentlyProcessedSegmentDuration = 0
        
        // 1
        audioEngine.stop()
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        // 2
        node.installTap(onBus: 0,
                        bufferSize: 1024,
                        format: recordingFormat) { [unowned self]
                            (buffer, _) in self.request.append(buffer)
        }
        
        // 3
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) {
            [unowned self]
            (result, error) in
                if let error = error {
                    print("There was an problem: \(error.localizedDescription)")
                    self.showErrorAlert(title: "Recorder error", message: "The operation couldn’t be completed.")
                } else {
                    if let transcription = result?.bestTranscription {
                        self.updateUIWithTranscription(transcription)
                    }
                }
        }
    }
    
    fileprivate func stopRecording() {
        audioEngine.stop()
        request.endAudio()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        self.transcriptionOutputLabel.text = "Try another command"
        recording = 0
        recordButton.setImage(UIImage(named: "recordButtonImage.png"), for: .normal)
        
    }
    
    fileprivate func showErrorAlert(title: String, message: String) {
        let alertTitle = title
        let alertMsg = message
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    fileprivate func updateUIWithTranscription(_ transcription: SFTranscription) {
        self.transcriptionOutputLabel.text = transcription.formattedString
        
        // Checking for keywords
        
        let appCommands:[String] = [
            "app",
            "application",
            "use",
            "work",
            "working"
        ]
        
        let tutorialCommands:[String] = [
            "tutorial",
            "guide",
            "teach"
        ]
        
        if tutorialCommands.contains(where: transcription.formattedString.lowercased().contains) {
            self.stopRecording()
            proceedToTutorial(nil)
            return
        } else if appCommands.contains(where: transcription.formattedString.lowercased().contains) {
            self.stopRecording()
            startUsingApp(nil)
            return
        }
        
    }
    
    @IBAction func proceedToTutorial(_ sender: Any?) {
        performSegue(withIdentifier: "modalTutorialFirstScreenSegue", sender: nil)
    }
    
    @IBAction func startUsingApp(_ sender: Any?) {
        performSegue(withIdentifier: "modalAppMainScreenSegue", sender: nil)
    }
    
    @IBAction func startRecordingAction(_ sender: Any) {
        if recording == 0 {
            self.transcriptionOutputLabel.text = "Recording"
            do {
                try self.startRecording()
            } catch let error {
                print("There was a problem starting recording: \(error.localizedDescription)")
            }
        } else {
            self.stopRecording()
        }
    }
}
