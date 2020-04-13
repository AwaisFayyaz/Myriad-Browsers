//
//  ViewController.swift
//  Browsed
//
//  Created by MacBook on 1/11/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    //MARK: IOutlets
    
    @IBOutlet weak var browsersTableView: UITableView!
    
    //MARK: Properties
    
//    var urlsArray = [String]()
    lazy var browsers = [Browser]()
    var user: User!
//    let ref = Database.database().reference(withPath: "tabData\(user.uid)")
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        let uid = Auth.auth().currentUser!.uid
//        let ref = Database.database().reference(withPath: "tabData").child(uid)
//        ref.removeAllObservers()
    }
    
    
    private func setupViews(){
        
        self.navigationController?.isNavigationBarHidden = false
        browsersTableView.delegate = self
        browsersTableView.dataSource = self
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference(withPath: "tabData").child(uid)
        
        ref.observe(.value, with: { snapshot in
            if snapshot.exists() {

                let value = snapshot.value as? NSDictionary
                var newItems: [Browser] = []
                if let browsers = value?.allValues {
                for item in browsers{
                        if let eachItem = item as? [String: AnyObject]{
                            
                            let urlString = eachItem["urlLink"] as! String
                            let numberOfTabs = eachItem["numberOfTabs"] as! Int
                            let id = eachItem["id"] as! String
                            let browser = Browser(url: urlString, id: id, noOfBrowsers: numberOfTabs)
                            newItems.append(browser)
                            
                        }
                        
                    }
                    
                    self.browsers = newItems
                    print(self.browsers, "self.browsers")
                    self.browsersTableView.reloadData()
                }
               
           } else {
                print("Firebase node doesn't exist")
                self.browsers.removeAll()
                self.browsersTableView.reloadData()
               
//               self.tableView.reloadData()
           }
            
        })
        
    }
    //MARK: IBActions
    
    @IBAction func addBrowserTapped(_ sender: Any) {
        
        presentAlert()
        
    }
    
    

    @IBAction func settingsButtonPressed(_ sender: AnyObject) {
        
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Log Out", style: .default, handler: { [weak alert] (_) in
            do {
                      try Auth.auth().signOut()
                        self.navigationController?.popViewController(animated: true)
            //          self.dismiss(animated: true, completion: nil)
                    } catch (let error) {
                      print("Auth sign out failed: \(error)")
                    }

        })
        
        let cancelbtn = UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            print("Text field: \(String(describing: textField?.text))")
        })
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(cancelbtn)
        alert.addAction(okBtn)
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
//      let user = Auth.auth().currentUser!
//      let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
//      onlineRef.removeValue { (error, _) in
//        if let error = error {
//          print("Removing online failed: \(error)")
//          return
//        }
//        do {
//          try Auth.auth().signOut()
//            self.navigationController?.popViewController(animated: true)
////          self.dismiss(animated: true, completion: nil)
//        } catch (let error) {
//          print("Auth sign out failed: \(error)")
//        }
//      }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func massDeleteTapped(_ sender: Any) {
                
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to close all tabs", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Close", style: .default, handler: { [weak alert] (_) in
            
            let uid = Auth.auth().currentUser!.uid
            let ref = Database.database().reference(withPath: "tabData").child(uid)
            ref.removeValue()
        })
        
        let cancelbtn = UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            print("Text field: \(String(describing: textField?.text))")
        })
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(cancelbtn)
        alert.addAction(okBtn)
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func massLinkTapped(_ sender: Any) {
        presentMassLinkAlert()
    }
    
    @IBAction func profileTapped(_ sender: Any) {
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        
    }
    //MARK: Private Functions

    private func presentAlert(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter URL", message: "Enter a URL to add Broswer", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter number of browsers"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.text = "https://"
            textField.keyboardType = .webSearch
        }
        
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let urlTextField = alert?.textFields?[1]
            let urlText = urlTextField?.text
            let noOfBrowsersText = alert?.textFields?.first?.text
            let noOfBrowsers = (noOfBrowsersText! as NSString).integerValue
            
//            guard let textField = alert.textFields?.first,
//              let text = textField.text else { return }
            
//            let noOfbrowsersTextField = alert?.textFields![0]
            
//            let numberOfBrowsers = 1
            if noOfBrowsers > 0{
                for _ in 1...noOfBrowsers{

                    if Auth.auth().currentUser != nil{
                        
                        let uid = Auth.auth().currentUser!.uid
                        let ref = Database.database().reference(withPath: "tabData").child(uid)
                        let groceryItemRef = ref.childByAutoId()
                        let refIdString : String = groceryItemRef.key!
                        let browser = Browser(url: urlText!,
                                              id: refIdString,
                                              noOfBrowsers: noOfBrowsers)

                        
                        groceryItemRef.setValue(browser.toAnyObject())
                        
                    }
    //                self.urlsArray.append(urlTextField!.text!)
    //                self.browsersTableView.reloadData()

                }
            }else {
                
                print("Enter valid number of tabs please")
                
            }

        })
        
        let cancelbtn = UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
        })
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(cancelbtn)
        alert.addAction(okBtn)
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    

    private func presentMassLinkAlert(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter URL", message: "Enter a URL to add Broswer", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
//        alert.addTextField { (textField) in
//            textField.placeholder = "Enter number of browsers"
//            textField.keyboardType = .numberPad
//        }
        alert.addTextField { (textField) in
            textField.text = "https://"
            textField.keyboardType = .webSearch
        }
        
        
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let urlTextField = alert?.textFields?[0]
            let urlText = urlTextField?.text
            for tab in self.browsers{

                    if Auth.auth().currentUser != nil{
                        
                        let tabId = tab.id
                        let uid = Auth.auth().currentUser!.uid
                        let ref = Database.database().reference(withPath: "tabData").child(uid).child(tabId)
                        ref.updateChildValues(["urlLink": urlText])
//                        ref.ref.setValue(<#T##value: Any?##Any?#>)
//                        updateChildValues([
//                          "urlLink": urlText
//                        ])
                        
                    }

                }

        })
        
        let cancelbtn = UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
        })
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(cancelbtn)
        alert.addAction(okBtn)
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func expandButtonTapped(_ sender: UIButton){
        
        let url = self.browsers[sender.tag].url
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ExpandedWebViewController") as! ExpandedWebViewController
        if let cell = browsersTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? BrowserTableViewCell {
            cell.webView.configuration.websiteDataStore.httpCookieStore.getAllCookies({ (cookies) in
                vc.cookies = cookies
                vc.urlString = url
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
        
        
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton){
        
        let uid = Auth.auth().currentUser!.uid
        let tabId = self.browsers[sender.tag].id
        let ref = Database.database().reference(withPath: "tabData").child(uid).child(tabId)
        ref.removeValue()
        
    }
    
    @objc private func duplicateButtonTapped(_ sender: UIButton){
        
        if Auth.auth().currentUser != nil{
            
            let uid = Auth.auth().currentUser!.uid
            let ref = Database.database().reference(withPath: "tabData").child(uid)
            let groceryItemRef = ref.childByAutoId()
            let refIdString : String = groceryItemRef.key!
            let url = self.browsers[sender.tag].url
            let browser = Browser(url: url,
                                  id: refIdString,
                                  noOfBrowsers: 1)

            
            groceryItemRef.setValue(browser.toAnyObject())
            
        }
        
    }

}

//MARK: Extensions
import WebKit
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: UITableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.browsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowserTableViewCell") as! BrowserTableViewCell
            
        let url = self.browsers[indexPath.row].url
        let urlRequest = URLRequest(url: URL(string: url)!)
        cell.webView.load(urlRequest)
        
        
        cell.expandBtn.tag = indexPath.row
        cell.closeBtn.tag = indexPath.row
        cell.duplicateBtn.tag = indexPath.row
        cell.expandBtn.addTarget(self, action: #selector(expandButtonTapped(_:)), for: .touchUpInside)
        cell.closeBtn.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        cell.duplicateBtn.addTarget(self, action: #selector(duplicateButtonTapped(_:)), for: .touchUpInside)
        cell.urlTextField.text = url
        print("cell.webView \(cell.webView as Any)")
//        cell.browserWebView.configuration.websiteDataStore.httpCookieStore.getAllCookies { (cookies) in
//            for cookie in cookies {
//                print("cookie: \(cookie)")
//            }
//        }
        print("===\n\n===")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
