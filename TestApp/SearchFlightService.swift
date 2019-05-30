//
//  SearchFlightService.swift
//  TestApp
//
//  Created by Valeria Toloconnicov on 5/21/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation

class SearchFlightService {
    var flights: Itineraries?

    init() {
        flights = Itineraries()
    }
    
    func retrieveFlights(origin: String, destination: String, departureDate: String) -> [FlightInfoModel]?{
        return flights?.itineraries
    }
}
