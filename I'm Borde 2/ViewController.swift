//
//  ViewController.swift
//  I'm Borde 2
//
//  Created by amr on 12/04/2022.
//

import UIKit
//import Alamofire



struct ActivityData: Codable{
    let activity : String
}
// Hello

struct ActivityText{
    let text:String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var randemButon: UIButton!
    @IBOutlet weak var cooking: UIButton!
    @IBOutlet weak var charity: UIButton!
    @IBOutlet weak var diy: UIButton!
    @IBOutlet weak var education: UIButton!
    @IBOutlet weak var music: UIButton!
    @IBOutlet weak var social: UIButton!
    @IBOutlet weak var recreational: UIButton!
    @IBOutlet weak var relaxation: UIButton!
    @IBOutlet weak var busywork: UIButton!
    @IBOutlet weak var labelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randemButon.titleLabel?.isHidden = true
        cooking.titleLabel?.isHidden = true
        charity.titleLabel?.isHidden = true
        diy.titleLabel?.isHidden = true
        education.titleLabel?.isHidden = true
        music.titleLabel?.isHidden = true
        social.titleLabel?.isHidden = true
        recreational.titleLabel?.isHidden = true
        relaxation.titleLabel?.isHidden = true
        busywork.titleLabel?.isHidden = true
    }
    
    @IBAction func getText(_ sender: UIButton) {
        
        guard var type = sender.titleLabel?.text else{
            fatalError("error with sender")
        }
        if type == "randem"{
            type = ""
            fetchText(with: type)
        }else{
            fetchText(with: type)
        }
        
    }
    
    
    func fetchText(with type:String){

        let urlString = "https://www.boredapi.com/api/activity?type=\(type)"

        if let url =  URL(string: urlString ) {
            let session  = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in

                if let safeData = data {
                    self.parsJson(with: safeData)

                }
            }
            task.resume()
        }
    }
    func parsJson(with data:Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ActivityData.self, from: data)
            let activity = decodedData.activity
            print(decodedData)
            DispatchQueue.main.async {
                self.labelText.text = activity
                print(activity)
            }
        }catch{
            print(error)
        }

    }
}

extension ViewController{
    func gitTest(){
        print("Changes Happened")
    }
    
}



