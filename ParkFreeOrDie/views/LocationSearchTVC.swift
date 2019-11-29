/*****************************************************************
* Project: ParkFreeOrDie
* Programmer: Jeremy Clark
* Programmer: Jayce Merinchuk
* File: LocationSearchTVC.swift
* Desccription: Displays a table of potential locations for the user
*
* Sources: Used a MapKit tutorial
*****************************************************************/

// Imports
import UIKit
import MapKit

/*****************************************************************
 * Class: LocationSearchTVC : UITableViewController
 * Description:  Manages the table that pops up when searching on the map.
*****************************************************************/
class LocationSearchTVC : UITableViewController {
    
    // Class Variables
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate:HandleMapSearch? = nil
    
    /*************************************************************
     * Method: parseAddress()
     * Description: Manages getting address of typed place in search bar.
    *************************************************************/
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
}

/*****************************************************************
 * Extension: LocationSearchTVC
 * Description: Updates results from search bar.
*****************************************************************/
extension LocationSearchTVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

/*****************************************************************
 * Extension: LocationSearchTVC
 * Description: Matches items for typed box.
*****************************************************************/
extension LocationSearchTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
}

/*****************************************************************
 * Extension: LocationSearchTVC
 * Description: Manages the selected item and dropped pin
*****************************************************************/
extension LocationSearchTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}


