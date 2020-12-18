//
//  ViewController.swift
//  Final
//
//  Created by Filipp Krupnov on 18/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [String]()
    var newWord: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        words = [""]
        wordsTableView .dataSource = self
        requestData()
        
        
    }
    
    @IBOutlet weak var wordsTableView: UITableView!
    @IBOutlet weak var WordTextfield: UITextField!
    
    @IBAction func addWordButtonTapped(_ sender: Any) {
        if WordTextfield.text != nil {
            var word = WordTextfield.text!
            words.append(word)
            wordsTableView.reloadData()
        }
    }
    
        
    func requestData() {
        let urlComponents = URLComponents(string: "https://aucatranslator.azurewebsites.net/api/v1/wordtranslation/?word=I")
        let wordsRequest = URLRequest(url: urlComponents!.url!)
        
        let sharedSession = URLSession.shared
        
        let wordTask = sharedSession.dataTask(with: wordsRequest) { (data, response, error) in
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<300) ~= response.statusCode,
               error == nil,
               let requestedWord = try? JSONDecoder().decode(Request.self, from: data){
                print(requestedWord)
               // UserDefaults.standard.set(requestedWord, forKey: "I")
            }
        }
        wordTask.resume()
        
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Translation", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func fullMessageTapped(_ sender: Any) {
        showAlert(withMessage: "name")//name .text!)
    }
}
    
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        
        cell.textLabel?.text = words[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        showAlert(withMessage: "I")
    }
    
}

