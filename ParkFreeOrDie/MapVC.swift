/*****************************************************************
 * Project: ParkFreeOrDie
 * Programmer: Jeremy Clark
 * Programmer: Jayce Merinchuk
 * File: MapVC.swift
 * Desccription:
 *
 * Sources:
 *
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
        let locationSearchTVC = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTVC") as! LocationSearchTVC
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
     * Method: setupSearchBar()
     * Description: Manage accuracy of map and authorization
    *************************************************************/
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

extension MapVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager:
        // Print an error if anything goes wrong
        CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
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
    
    // Handles location updates and requests and displays location on map
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
    
    func addPinToMap(title: String?, lat: CLLocationDegrees, long: CLLocationDegrees) {
        if let title = title {
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let myAnnotation = MKPointAnnotation()
            myAnnotation.title = title
            myAnnotation.coordinate = location
            self.mapView.addAnnotation(myAnnotation)
//            self.mapView  .showAnnotations([myAnnotation], animated: true)
        }
    }
}

extension MapVC : HandleMapSearch {
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
    }
}

extension MapVC : MKMapViewDelegate {
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
