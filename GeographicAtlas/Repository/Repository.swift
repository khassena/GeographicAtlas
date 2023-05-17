//
//  Repository.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

protocol RepositoryProtocol {
    
    init(networkTask: NetworkTaskProtocol)
    var networkTask: NetworkTaskProtocol? { get set }
    func countriesListDataToSections(_ countriesList: [CountriesList]) -> [[CountriesListData]]?
    func countriesListElementToCell(_ countriesList: CountriesList) -> CountriesListData
    func countryDetailDataToTransfer(_ countryDetail: [Country]) -> ([String], (String, String, String))
}

class Repository: RepositoryProtocol {
    
    var networkTask: NetworkTaskProtocol?
    
    // MARK: - Initialization
    
    required init(networkTask: NetworkTaskProtocol) {
        self.networkTask = networkTask
    }

}

// MARK: - Public Methods

extension Repository {
    
    func countriesListDataToSections(_ countriesList: [CountriesList]) -> [[CountriesListData]]? {
        
        var europe = [CountriesListData]()
        var asia = [CountriesListData]()
        var africa = [CountriesListData]()
        var oceania = [CountriesListData]()
        var southAmerica = [CountriesListData]()
        var northAmerica = [CountriesListData]()
        var antarctica = [CountriesListData]()
        
        countriesList.forEach { country in
            let countriesListElement = countriesListElementToCell(country)
            
        
            switch countriesListElement.continent.first {
            case .europe:
                 europe.append(countriesListElement)
            case .asia:
                asia.append(countriesListElement)
            case .africa:
                africa.append(countriesListElement)
            case .oceania:
                oceania.append(countriesListElement)
            case .southAmerica:
                southAmerica.append(countriesListElement)
            case .antarctica:
                antarctica.append(countriesListElement)
            case .northAmerica:
                northAmerica.append(countriesListElement)
            case .none:
                print("Error, not found continent")
            }
            
        }
        
        return [europe, asia, africa, oceania, southAmerica, northAmerica, antarctica]
    }
    
    func countryDetailDataToTransfer(_ countryDetail: [Country]) -> ([String], (String, String, String)) {
        
        guard let country = countryDetail.first else { return ([""],("", "", "")) }
        
        let data = countryDetailToCell(country)
        return ([data.subRegion, data.capitalCity, data.capitalCoordinates, data.population, data.area, data.currency, data.timezone], (data.countryName, data.flagUrl, data.maps))
    }
    
    func countriesListElementToCell(_ countriesList: CountriesList) -> CountriesListData {
        convertCountriesListElementToCell(countriesList)
    }
    
    func countryDetailToCell(_ country: Country) -> DetailsModel {
        convertCountryDetailToCell(country)
    }
    
}

// MARK: - Private Methods

private extension Repository {
    
    func convertCountriesListElementToCell(_ countriesList: CountriesList) -> CountriesListData {
        
        let populationString = convertPopulationToString(countriesList.population)
        let areaString = convertAreaToString(countriesList.area)
        let currencyString = convertCurrencyToString(countriesList.currency)
        
        return CountriesListData(
            countryName: countriesList.name.common,
            capitalCity: countriesList.capital?.first ?? "There is no Capital City",
            flagUrl: countriesList.flag.png,
            population: populationString,
            area: areaString,
            currency: currencyString,
            continent: countriesList.continent,
            ccaTwoCode: countriesList.ccaTwo
        )
    }
    
    func convertCountryDetailToCell(_ country: Country) -> DetailsModel {
        
        let populationString = convertPopulationToString(country.population)
        let areaString = convertAreaToString(country.area)
        let currencyString = convertCurrencyToString(country.currency)
        let coordinates = convertCoordinatesToString(country.coordinates)
        let timeZones = calculateAverageGMT(timeZones: country.timeZones)
        
        return DetailsModel(
            countryName: country.name.common,
            capitalCity: country.capital?.first ?? "There is no Capital City",
            subRegion: country.subRegion ?? "There is no Region",
            flagUrl: country.flag.png,
            population: populationString,
            capitalCoordinates: coordinates,
            timezone: timeZones,
            area: areaString,
            currency: currencyString,
            maps: country.maps.openStreetMaps ?? ""
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
    
    func convertCurrencyToString(_ currency: [String: Currency]?) -> String {
        
        guard let code = currency?.keys.first,
              let name = currency?[currency?.keys.first ?? ""]?.name,
              let symbol = currency?[currency?.keys.first ?? ""]?.symbol else {
            return "nil"
        }

        return "\(name) (\(symbol)) (\(code))"
    }
    
    func convertCoordinatesToString(_ coordinates: [Double]) -> String {
        guard let latitude = coordinates.first,
              let longitude = coordinates.last else { return "nil" }
        
        let latitudeDegrees = Int(latitude)
        let latitudeMinutes = Int((latitude - Double(latitudeDegrees)) * 60)
        
        let longitudeDegrees = Int(longitude)
        let longitudeMinutes = Int((longitude - Double(longitudeDegrees)) * 60)
        
        let latitudeString = String(format: "%d°%02d′", latitudeDegrees, latitudeMinutes)
        let longitudeString = String(format: "%d°%02d′", longitudeDegrees, longitudeMinutes)
        
        return "\(latitudeString), \(longitudeString)"
    }
    
    func calculateAverageGMT(timeZones: [String?]) -> String {
        var convertedTimezones: [String] = []
        
        for timezone in timeZones {
            if let timezone = timezone {
                if timezone.hasPrefix("UTC+") {
                    let offsetIndex = timezone.index(timezone.startIndex, offsetBy: 4)
                    let offset = timezone[offsetIndex...]
                    let convertedTimezone = "GMT+\(offset)"
                    convertedTimezones.append(convertedTimezone)
                } else if timezone.hasPrefix("UTC-") {
                    let offsetIndex = timezone.index(timezone.startIndex, offsetBy: 4)
                    let offset = timezone[offsetIndex...]
                    let convertedTimezone = "GMT-\(offset)"
                    convertedTimezones.append(convertedTimezone)
                } else {
                    convertedTimezones.append(timezone)
                }
            }
        }
        
        let combinedTimezones = convertedTimezones.joined(separator: ", ")
        return combinedTimezones
    }
}
