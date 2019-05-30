//
//  InstaFlightResponse.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 5/13/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import SwiftyJSON

struct Itineraries {
    var itineraries = [FlightInfoModel]()
    
    init() {
        let json = JSON(readJSONFile())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        
        let itineraryGroup = json["itineraries"].arrayValue
            for itinerary in itineraryGroup {
                let id = itinerary["id"].intValue
                let eTicketable = itinerary["passengerInfo"]["eTicketable"].boolValue
                let lastTicketDateString = itinerary["passengerInfo"]["lastTicketDate"].stringValue
                let lastTicketDate = dateFormatter.date(from: lastTicketDateString)!
                
                let totalPrice = itinerary["pricingInformation"]["totalPrice"].stringValue
                let seatsAvailable = itinerary["passengerInfo"]["seatsAvailable"].intValue
                let nonRefundable = itinerary["passengerInfo"]["nonRefundable"].boolValue
                let currency = itinerary["pricingInformation"]["currency"].stringValue
                let mealCode = itinerary["passengerInfo"]["mealCode"].stringValue
                let departureAirport = itinerary["departureAirportLabel"].stringValue
                let arrivalAirport = itinerary["arrivalAirportLabel"].stringValue
                
                let flightInfo = FlightInfoModel(id: id, eTicketable: eTicketable, lastTicketDate: lastTicketDate, totalPrice: totalPrice, seatsAvailable: seatsAvailable, nonRefundable: nonRefundable, departureAirport: departureAirport, arrivalAirport: arrivalAirport, currency: currency, mealCode: mealCode)
                
                itineraries.append(flightInfo)
            }
        
        
    }
    
    func readJSONFile() -> [String : Any] {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "FlightItineraries", ofType: "json")
        
        do {
            let string = try String.init(contentsOfFile: path!, encoding: .utf8)
            
            let data = string.data(using: .utf8)!
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String : Any]
                {
                    return jsonArray
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        catch {}
        return [:]
    }
}

struct FlightInfoModel {
    var id: Int?
    var eTicketable: Bool?
    var lastTicketDate: Date?
    var totalPrice: String?
    var seatsAvailable: Int?
    var nonRefundable: Bool?
    var departureAirport: String?
    var arrivalAirport: String?
    var currency: String?
    var mealCode: String?
    
    init(id: Int, eTicketable: Bool, lastTicketDate: Date, totalPrice: String, seatsAvailable: Int, nonRefundable: Bool, departureAirport: String, arrivalAirport: String, currency: String, mealCode: String) {
        self.id = id
        self.eTicketable = eTicketable
        self.lastTicketDate = lastTicketDate
        self.totalPrice = totalPrice
        self.seatsAvailable = seatsAvailable
        self.nonRefundable = nonRefundable
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.currency = currency
        self.mealCode = mealCode
    }
    
}
