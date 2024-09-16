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
}
#endif
