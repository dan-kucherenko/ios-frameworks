//
//  UniversalMapProtocol.swift
//  L2_project
//
//  Created by Ihor Malovanyi on 17.10.2022.
//

import MapKit
#if canImport(GoogleMaps)
import GoogleMaps
#endif

// MARK: - Provider protocol for Google Maps and MKMap
protocol UniversalMapProvider {
    
    var universalMapConfiguration: UniversalMapService.Configuration { get set }
    var needLongPressGesture: Bool { get }
    
    init()
    
    func addPin(with title: String, to coordinate: CLLocationCoordinate2D)
    func centerOnUser(at location: CLLocationCoordinate2D)
    func searchPath(to location: CLLocationCoordinate2D)
    
}

// MARK: - MapKit
extension MKMapView: UniversalMapProvider {
    
    var needLongPressGesture: Bool { true }
    
    var universalMapConfiguration: UniversalMapService.Configuration {
        get {
            .init(mapType:
                    self.mapType == .standard || self.mapType == .mutedStandard ? .normal :
                    self.mapType == .hybrid || self.mapType == .hybridFlyover ? .hybrid :
                    .satellite
            )
        }
        set {
            switch newValue.mapType {
            case .normal: self.mapType = .standard
            case .satellite: self.mapType = .satellite
            case .hybrid: self.mapType = .hybrid
            }
        }
    }
    
    func addPin(with title: String, to coordinate: CLLocationCoordinate2D) {
        removeAnnotations(annotations)
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        
        addAnnotation(annotation)
    }
    
    func centerOnUser(at location: CLLocationCoordinate2D) {
        let camera = MKMapCamera(
            lookingAtCenter: location,
            fromDistance: 1000,
            pitch: 0,
            heading: .zero
        )
        self.setCamera(camera, animated: true)
    }
    
    func searchPath(to location: CLLocationCoordinate2D) {
        let userCoordinates = UserLocationService.shared.currentLocation
        let sourcePlaceMark = MKPlacemark(coordinate: userCoordinates ?? CLLocationCoordinate2D())
        let destinationPlaceMark = MKPlacemark(coordinate: location)
        
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { [weak self] responce, error in
            if let responce = responce, error == nil {
                self?.drawRoute(with: responce.routes[0], userCoordinates: userCoordinates ?? CLLocationCoordinate2D())
            }
        }
    }
    
    private func drawRoute(with route: MKRoute, userCoordinates: CLLocationCoordinate2D) {
        removeOverlays(self.overlays)
        
        addOverlay(route.polyline)
        let rect = route.polyline.boundingMapRect
        setRegion(MKCoordinateRegion(rect), animated: true)
        
        let userPosition = MKPointAnnotation()
        userPosition.coordinate = userCoordinates
        userPosition.title = "You"
        addAnnotation(userPosition)
    }
}

// MARK: - Google Maps
#if canImport(GoogleMaps)
extension GMSMapView: UniversalMapProvider {
    
    var needLongPressGesture: Bool { false }
    
    var universalMapConfiguration: UniversalMapService.Configuration {
        get {
            .init(mapType:
                    self.mapType == .normal ? .normal :
                    self.mapType == .hybrid ? .hybrid :
                    .satellite
            )
        }
        set {
            switch newValue.mapType {
            case .normal: self.mapType = .normal
            case .satellite: self.mapType = .satellite
            case .hybrid: self.mapType = .hybrid
            }
        }
    }
    
    func addPin(with title: String, to coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.title = title
        marker.map = self
    }
    
    func centerOnUser(at location: CLLocationCoordinate2D) {
        let location = GMSCameraPosition.camera(withTarget: location, zoom: 18)
        self.animate(to: location)
    }
    
    func searchPath(to location: CLLocationCoordinate2D) {
        guard let userCoordinates = UserLocationService.shared.currentLocation else { return }
        clear()
        let fromLocation = "\(userCoordinates.latitude),\(userCoordinates.longitude)"
        let toLocation = "\(location.latitude),\(location.longitude)"
            
        addPin(with: toLocation, to: location)
        addPin(with: "You", to: userCoordinates)
        guard let url = requestDirectionURL(from: fromLocation, to: toLocation) else { return }
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any],
               let array = json["routes"] as? NSArray {
                drawRoute(with: array)
            }
        }
    }
    
    func drawRoute(with array: NSArray) {
        var bounds = GMSCoordinateBounds()

        array.forEach { route in
            let routeOverviewPolyline = (route as? NSDictionary)?.value(forKey:"overview_polyline") as? NSDictionary
            if let points = routeOverviewPolyline?.object(forKey: "points") as? String {
                let path = GMSPath(fromEncodedPath: points)
                let polyline = GMSPolyline(path: path)
                polyline.strokeWidth = 5
                polyline.strokeColor = .blue
                polyline.map = self
                
                for i in 0..<path!.count() {
                    bounds = bounds.includingCoordinate(path!.coordinate(at: i))
                }
            }
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        self.animate(with: update)
    }
    
    func requestDirectionURL(
        from fromLocation: String,
        to toLocation: String
    ) -> URL? {
        var request = URLComponents(string: "https://maps.googleapis.com/maps/api/directions/json")
        request?.queryItems = [
            URLQueryItem(name: "origin", value: fromLocation),
            URLQueryItem(name: "destination", value: toLocation),
            URLQueryItem(name: "mode", value: "driving"),
            URLQueryItem(name: "key", value: "AIzaSyALh6FQ5hHZffihP8rt42mXPlGwXk6_mhA")
        ]
        
        return request?.url
    }
}
#endif
