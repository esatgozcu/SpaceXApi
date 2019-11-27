//
//  Copyright © 2019 esatgozcu. All rights reserved.
//

import UIKit

class LaunchesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    
    var apiUrl = "https://api.spacexdata.com/v3/launches/"
    
    var launchArray = [Launch]()
    var filteredList = [Launch]()
    
    var pickerArray = [String]()
    var pickerSelectedIndex =  0
    
    var backViewPicker = UIButton()
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    let pickerFilter = ["2006","2007","2008","2009","2010","2012","2013","2014","2015","2016","2017","2018","2019","2020"]
    let pickerSorting = ["Year - Back to old","Year - Old to new"]
    
    var sortingOrFilterControl = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Launches"
        getJSONData()
    }
    
    func getJSONData(){
        let url = URL(string: apiUrl)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let value = data else { return }
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode([Launch].self, from: value)
                self.filteredList = user
                self.launchArray = user
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        filterButton.isEnabled = false
        sortingButton.isEnabled = false
        pickerArray = pickerFilter
        createPickerViewAndToolbar()
        sortingOrFilterControl = true
    }
    
    @IBAction func sortingButton(_ sender: Any) {
        sortingButton.isEnabled = false
        filterButton.isEnabled = false
        pickerArray = pickerSorting
        createPickerViewAndToolbar()
        sortingOrFilterControl = false
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        backViewPicker.removeFromSuperview()
        filterButton.isEnabled = true
        sortingButton.isEnabled = true
        
        if sortingOrFilterControl {
            let newArray = launchArray.filter{ $0.launchYear == pickerFilter[pickerSelectedIndex]}
            filteredList = newArray
            tableView.reloadData()
        }
        else{
            if pickerSelectedIndex == 0{
                let newArray = filteredList.sorted(by:{$1.launchYear!.localizedStandardCompare($0.launchYear!) == .orderedAscending})
                filteredList = newArray
                tableView.reloadData()
            }
            else{
                let newArray = filteredList.sorted(by:{$0.launchYear!.localizedStandardCompare($1.launchYear!) == .orderedAscending})
                filteredList = newArray
                tableView.reloadData()
            }
        }
    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        backViewPicker.removeFromSuperview()
        filterButton.isEnabled = true
        sortingButton.isEnabled = true
    }
    
    @objc func onClearButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        backViewPicker.removeFromSuperview()
        filterButton.isEnabled = true
        sortingButton.isEnabled = true
        filteredList = launchArray
        tableView.reloadData()
    }
    
    func createPickerViewAndToolbar(){
    
        backViewPicker = UIButton.init()
        backViewPicker.frame = UIScreen.main.bounds
        backViewPicker.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        backViewPicker.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        self.view.addSubview(backViewPicker)
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(onClearButtonTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.tintColor = .red
        toolBar.barTintColor = .white
        self.view.addSubview(toolBar)
    }
}

//MARK: PickerView Data Source
extension LaunchesVC : UIPickerViewDelegate, UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
}

//MARK: TableView Data Source
extension LaunchesVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LaunchCell
        cell.flightNumber.text = "Flight: \(filteredList[indexPath.row].flightNumber?.intValue() ?? 0)"
        cell.launchDate.text = filteredList[indexPath.row].launchYear
        cell.missionName.text = filteredList[indexPath.row].missionName
        cell.missionImage.setImageForUrl(filteredList[indexPath.row].links?.missionPatchSmall)
        cell.vehicleName.text = filteredList[indexPath.row].rocket?.rocketName
                
        if filteredList[indexPath.row].launchSuccess != nil{
            if filteredList[indexPath.row].launchSuccess!{
                cell.launchState.backgroundColor = UIColor.green
                cell.launchState.text = "Success"
                cell.launchState.textColor = UIColor.black
            }
            else{
                cell.launchState.backgroundColor = UIColor.red
                cell.launchState.text = "Failure"
                cell.launchState.textColor = UIColor.white
            }
        }
        else{
            cell.launchState.backgroundColor = UIColor.blue
            cell.launchState.text = "Upcoming"
            cell.launchState.textColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LaunchDetailVC.launchDetail = filteredList[indexPath.row]
        performSegue(withIdentifier: "details", sender: self)
    }
}
