//
//  DataDetailViewController.swift
//  ParsingDataJSON
//
//  Created by DOTS2 on 11/2/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class DataDetailViewController: UIViewController {
    
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelUse: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelName: UILabel!
    var passName:String?
    var passCountry:String?
    var passUse:String?
    var passAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = passName!
        labelCountry.text =  passCountry!
        labelUse.text = passUse!
        labelAmount.text =  "$\(passAmount)"
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
