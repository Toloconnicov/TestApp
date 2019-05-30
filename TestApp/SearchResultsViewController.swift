//
//  SearchResultsViewController.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 5/7/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    var itineraries: [FlightInfoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultsCell
        
        cell.completeCellWithContent(itinerary: itineraries![indexPath.row])
        return cell

    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itineraries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

 }

class SearchResultsCell: UITableViewCell {
    
    @IBOutlet weak var flightID: UILabel!
    @IBOutlet weak var departureAirport: UILabel!
    @IBOutlet weak var arrivalAirport: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var ticketPriceCurrency: UILabel!
    @IBOutlet weak var mealCode: UILabel!
    @IBOutlet weak var seatsAvailable: UILabel!
    @IBOutlet weak var lastTicketDate: UILabel!

    func completeCellWithContent(itinerary: FlightInfoModel) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myString = dateFormatter.string(from: itinerary.lastTicketDate!)
        
        flightID.text = String(itinerary.id!)
        departureAirport.text = itinerary.departureAirport
        arrivalAirport.text = itinerary.arrivalAirport
        ticketPrice.text = itinerary.totalPrice
        ticketPriceCurrency.text = itinerary.currency
        mealCode.text = itinerary.mealCode
        seatsAvailable.text = String(itinerary.seatsAvailable!)
        lastTicketDate.text = myString
        
    }
}
