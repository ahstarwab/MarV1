//
//  ViewController.swift
//  MarV1
//
//  Created by Release on 2018. 5. 16..
//  Copyright © 2018년 NF. All rights reserved.
//

import UIKit


enum Feature: Int{
    case solarPanels = 0, greenhouses, size
}

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    //let model = MarHabitatPricer()

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let solarPanelsDataSource = SolarPanelDataSource()
    private let greenhousesDataSource = GreenhousesDataSource()
    private let sizeDataSource = SizeDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(" Selected row = ", row)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row : Int, forComponent component: Int) -> String?{
        guard let feature = Feature(rawValue: component) else{
            fatalError("Invalid component \(component) found to to represent a \(Feature.self). This should not happen based on the configuration set in the storyboard.")
            
        }
        
        return self.title(for: row, feature: feature)
    }
  

    

    
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch Feature(rawValue: component)!{
        case .solarPanels:  return solarPanelsDataSource.values.count
        case .greenhouses:  return greenhousesDataSource.values.count
        case .size:         return sizeDataSource.values.count
            
        }
    }
   
    func title(for row: Int, feature: Feature) -> String?{
        switch feature{
        case .solarPanels:  return solarPanelsDataSource.title(for: row)
        case .greenhouses:  return greenhousesDataSource.title(for: row)
        case .size:         return sizeDataSource.title(for: row)
            
        }
    }
   
    func value(for row: Int, feature: Feature) -> Double{
        let value: Double?
        
        switch feature{
        case .solarPanels: value = solarPanelsDataSource.value(for: row)
        case .greenhouses: value = greenhousesDataSource.value(for: row)
        case .size:        value = sizeDataSource.value(for: row)
            
        }
        
        return value!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
}



struct SolarPanelDataSource {
    let values = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
    
    func title(for index: Int) -> String? {
        guard index < values.count else{ return nil }
        return String(values[index])
    }
    
    func value(for index: Int) -> Double? {
        guard index < values.count else { return nil }
        return Double(values[index])
    }
    
}

struct GreenhousesDataSource {
    let values = [1, 2, 3, 4, 5]
    func title(for index: Int) -> String? {
        guard index < values.count else { return nil }
        return String(values[index])
    }
    
    func value(for index: Int) -> Double? {
        guard index < values.count else { return nil }
        return Double(values[index])
    }
}

struct SizeDataSource {
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    
    let values = [
        750,
        1000,
        1500,
        2000,
        3000,
        4000,
        5000,
        10_000
    ]
    
    func title(for index: Int) -> String? {
        guard index < values.count else{ return nil }
        return SizeDataSource.numberFormatter.string(from: NSNumber(value: values[index]))
    }
    
    func value(for index: Int) -> Double? {
        guard index < values.count else { return nil }
        return Double(values[index])
    }
    
    
}







