//
//  Repository.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

protocol RepositoryProtocol {
    
    init(networkTask: NetworkTask)

    func countriesListElementToCell(_ countriesList: CountriesList) -> CountriesListForCell
}

class Repository: RepositoryProtocol {
    
    var networkTask: NetworkTask?
    
    // MARK: - Initialization
    
    required init(networkTask: NetworkTask) {
        self.networkTask = networkTask
    }

}

// MARK: - Public Methods

extension Repository {
    
    func countriesListElementToCell(_ countriesList: CountriesList) -> CountriesListForCell {
        convertCountriesListElementToCell(countriesList)
    }
    
}

// MARK: - Private Methods

private extension Repository {
    
    func convertCountriesListElementToCell(_ countriesList: CountriesList) -> CountriesListForCell {
        
        let populationString = convertPopulationToString(countriesList.population)
        let areaString = convertAreaToString(countriesList.area)
        let currencyString = convertCurrencyToString(countriesList.currency)
        
        return CountriesListForCell(
            countryName: countriesList.name.common,
            capitalCity: countriesList.capital?.first ?? "nil",
            flagUrl: countriesList.flag.png,
            population: populationString,
            area: areaString,
            currency: currencyString,
            continent: countriesList.continent
        )
    }
    
    func convertPopulationToString(_ population: Int) -> String {
        
        let mln = Constants.Numbers.millionInt
        let formattedPopulation: String
        
        if population >= mln * mln {
          let billionPopulation = Double(population) / Double(mln * mln)
          formattedPopulation = String(format: "%.2f bn", billionPopulation)
        } else if population >= mln {
          let mlnPopulation = Double(population) / Double(mln)
          formattedPopulation = String(format: "%.2f mln", mlnPopulation)
        } else if population >= 1000 {
          formattedPopulation = "\(population/1000)K"
        } else {
            formattedPopulation = "\(population) "
        }
        
        return formattedPopulation
    }
    
    func convertAreaToString(_ area: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if area >= Constants.Numbers.millionCGFloat {
            let areaMln = area / Constants.Numbers.millionCGFloat
            formatter.maximumFractionDigits = Constants.Numbers.three
            let areaMlnString = formatter.string(from: NSNumber(value: areaMln)) ?? ""
            return "\(areaMlnString) mln km²"
        } else {
            let areaThousand = Int(area)
            formatter.groupingSeparator = " "
            let areaThousandString = formatter.string(from: NSNumber(value: areaThousand)) ?? ""
            return "\(areaThousandString) km²"
        }
    }
    
    func convertCurrencyToString(_ currency: [String: CountriesList.Currency]?) -> String {
        
        guard let code = currency?.keys.first,
              let name = currency?[currency?.keys.first ?? ""]?.name,
              let symbol = currency?[currency?.keys.first ?? ""]?.symbol else {
            return "nil"
        }

        return "\(name) (\(symbol)) (\(code))"
    }
}
