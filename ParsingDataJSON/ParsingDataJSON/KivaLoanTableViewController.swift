//
//  KivaLoanTableViewController.swift
//  ParsingDataJSON
//
//  Created by DOTS2 on 11/1/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
    
    var namaSelected:String?
    var CountrySelected:String?
    var UseSelected:String?
    var AmountSelected: Int = 0
    
    
    //deklarasikan url untuk mengambil datajson
    let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    //deklarasika varibale loans untuk mengambil class Loan yang sudah dibuat sebelumnya
    var loans = [Loan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //mengambil data Dari API loans
        getLatestLoans()
        
        //self sizingcell
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KivaLoanTableViewCell

        // Configure the cell...
        //memasukan nilainya kedalam masing 2 label
        cell.LabelName.text = loans[indexPath.row].name
        cell.LabelCountry.text = loans[indexPath.row].country
        cell.LabelUse.text = loans[indexPath.row].use
        cell.LabelAmount.text = "$\(loans[indexPath.row].amount)"
        
        let data = loans[indexPath.row]
        

        return cell
    }
   
    // MARK: - JSON PArsing
    // membuat method baru dengan nama: getLstestLoans()
    func getLatestLoans() {
        
    //deklarsi LoanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasikan sebelumnya
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return //return ini memiliki ffungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
 
        //delarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengambil nilai error yang didapat
            }
            
            //parse JSON data
            //deklarasi variable data untuk mengambil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.loans = self.parseJsonData(data: data)
                
                //Reload TAble view
                OperationQueue.main.addOperation ({
                    //reload Data kembali
                    self.tableView.reloadData()
                })
            }
            
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
        //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data Json
    func parseJsonData(data: Data) -> [Loan] {
        //deklarasi variable loans sebagai obejct dari kelas Loan
        var loans = [Loan]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do{
            //deklarasikan jsonResult untuk mengambil data jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            //Parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResults yang bernama Loans
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans{
                //deklarasi loan sebagai objek dari class Loan
                let loan = Loan()
                //memasukan nilai ke dalam masing2 object dari class Loan
                //memasukan nilai jsonLoan dengan nama object nama sbg string
                loan.name = jsonLoan["name"] as! String
                //memasukan nilai jsonLoan dengan nama object loan_amount sbg Interger
                loan.amount = jsonLoan["loan_amount"] as! Int
                //memasukan nilai jsonLoan dengan nama object use sbg string
                loan.use = jsonLoan["use"] as! String
                //memasukan nilai jsonLoan dengan nama object location loan_amount sbg string
                let location = jsonLoan["location"] as! [String:AnyObject]
                //memasukan nilai jsonLoan dengan nama country  sbg String
                loan.country = location["country"] as! String
                //memasukan nilai jsonLoan dengan nama object loan_amount sbg Interger
                loans.append(loan)
            }
        }catch{
            print(error)
        }
        return loans
    }
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = loans[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        namaSelected = task.name
        CountrySelected = task.country
        UseSelected = task.use
        AmountSelected = task.amount
        
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "PassData", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "PassData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let kirimData = segue.destination as! DataDetailViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            kirimData.passName = namaSelected
            //mengirimkan data gambar wisata
            kirimData.passCountry = CountrySelected
            kirimData.passUse = UseSelected
            kirimData.passAmount = AmountSelected
            

        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
