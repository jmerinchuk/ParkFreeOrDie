/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: MapVC.swift
 * Desccription:
 *
 * Sources:
 *      Reverse Geocoding Address from Lat and Long
 *      https://stackoverflow.com/questions/41358423/swift-generate-an-address-format-from-reverse-geocoding
 *****************************************************************/

// Imports
import UIKit
import MapKit
import CoreLocation

/*****************************************************************
 * Protocol: HandleMapSearch
 * Description: Uses function to drop pin and zoom
*****************************************************************/
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

/*****************************************************************
 * Class: MapVC : UIViewController
 * Description:
*****************************************************************/
class MapVC : UIViewController {

    // Class Variables
    var locationManager = CLLocationManager()
    var resultSearchController : UISearchController? = nil
    var selectedPin : MKPlacemark? = nil
    var regionRadius : CLLocationDistance = 700
    var pinLat : Double = 0.00
    var pinLong : Double = 0.00
    
    // Variables to be passed
    var street : String = ""
    var city : String = ""
    var postal : String = ""
    var country : String = ""
    var hoursParked : Int = 0
    
    // Outlets
    @IBOutlet var mapView : MKMapView!
    
    /*************************************************************
     * Method: viewDidLoad()
     * Description: Initial Loaded Function
    *************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapAppearance()
        setupLocationManager()
        setupSearchTable()
        setupSearchBar()
    }
    
    /*************************************************************
     * Method: setupMapAppearance()
     * Description: Manages Map Appearance
    *************************************************************/
    func setupMapAppearance() {
        mapView.mapType = MKMapType.hybrid
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
    }
    
    /*************************************************************
     * Method: setupLocationManager()
     * Description: Manage accuracy of map and authorization
    *************************************************************/
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // Get location updates with callbacks
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
        }
    }
    
    /*************************************************************
     * Method: setupSearchTable()
     * Description: Manage accuracy of map and authorization
    *************************************************************/
    func setupSearchTable() {
        let locationSearchTVC = storyboard!.instantiateViewController(withIdentifier: "LocationSearchScene") as! LocationSearchTVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTVC)
        resultSearchController?.searchResultsUpdater = locationSearchTVC
        locationSearchTVC.mapView = mapView
        locationSearchTVC.handleMapSearchDelegate = self
    }
    
    /*************************************************************
     * Method: setupSearchBar()
     * Description: Manage search bar
    *************************************************************/
    func setupSearchBar() {
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for parking"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    /*************************************************************
     * Method: getAddress()
     * Description: Gets address of Annotation and returns it to the previous screen.
    *************************************************************/
    @IBAction func getAddress(_ sender: Any) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = pinLat
        center.longitude = pinLong

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    if pm.thoroughfare != nil {
                        self.street = pm.thoroughfare!
                    }
                    if pm.locality != nil {
                        self.city = pm.locality!
                    }
                    if pm.country != nil {
                        self.country = pm.country!
                    }
                    if pm.postalCode != nil {
                        self.postal = pm.postalCode!
                    }
                    
                    print("You will be parking at: " + self.street + " " + self.city + " " + self.country + " " + self.postal)
                    
                    self.openScene()
              }
        })
    }
    
    /*************************************************************
     * Method: openScene
     * Description: Opens confirm parking scene to confirm parking location
    *************************************************************/
    func openScene() {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let confirmParkingVC = mainSB.instantiateViewController(withIdentifier: "ConfirmParkingScene") as! ConfirmParkingVC
        
        confirmParkingVC.street = self.street
        confirmParkingVC.city = self.city
        confirmParkingVC.postal = self.postal
        confirmParkingVC.country = self.country
        confirmParkingVC.hoursParked = self.hoursParked
//        print("MapVC Variables: " + self.street + " " + self.city + " " + self.postal + " " + self.country)
        navigationController?.pushViewController(confirmParkingVC, animated: true)
    }
    
    /*************************************************************
     * Method: getDirections()
     * Description: Opens map to get directions to parking facility
    *************************************************************/
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

/*****************************************************************
 * Extension MapVC : CLLocationManagerDelegate
 * Description: Manages Authorization to user's location
*****************************************************************/
extension MapVC : CLLocationManagerDelegate {
    
    /*************************************************************
     * Method: locationManager()
     * Description: Handles user location error by printing error to console
    *************************************************************/
    func locationManager(_ manager:
        // Print an error if anything goes wrong
        CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    /*************************************************************
     * Method: locationManager()
     * Description: Handles different location authorizations
    *************************************************************/
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
        case .authorizedAlways:
            // code to Operate in BG using location access
            break
        case .denied:
            // change permission, loop to ask for permission until access granted, tell to uninstall
            break
        case .notDetermined:
            // if user has not given permission settings yet, ask
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            break
        case .restricted:
            break
        @unknown default:
            break
        }
    }
    
    /*************************************************************
     * Method: locationManager()
     * Description: Handles location updates and requests and displays location on map
    *************************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // If previous location exists, get it.
        if locations.last != nil {
            print("Location: \(String(describing: locations.last))")
        }
        
        print("Updating location...")
        // Create senter point of location to be displayed on map
        let center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        print("Center: \(center)")
        
        // Create a Region to be displayed on map using 2D coordinates
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        // Display region on Map
        self.mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = center
        myAnnotation.title = "You are here!"
        mapView.addAnnotation(myAnnotation)
        
    }
}

/*****************************************************************
 * Extension MapVC : HandleMapSearch
 * Description: Uses function to drop pin and zoom
*****************************************************************/
extension MapVC : HandleMapSearch {
    
    /*************************************************************
     * Method: dropPinZoonIn(placemark)
     * Description: Drops pin annotaion and zooms in on screen
    *************************************************************/
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // set pinLat and pinLong
        pinLat = annotation.coordinate.latitude
        pinLong = annotation.coordinate.longitude
    }
}

/*****************************************************************
 * Extension MapVC : MKMapViewDelegate
 * Description: Assists in getting directions to parking facility
*****************************************************************/
extension MapVC : MKMapViewDelegate {
    
    /*************************************************************
     * Method: mapView()
     * Description: Handles User Location dot and pulls getDirections function
    *************************************************************/
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.blue
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
        button.addTarget(self, action: Selector(("getDirections")), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
