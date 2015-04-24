//
//  LocationManager.swift
//  Secrets
//
//  Created by James Craige on 4/24/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import CoreLocation
import PromiseKit

class LocationManager {
    class func currentNeighborhood() -> Promise<String> {
        return requestAuthorizationWhenInUse().then { _ in
            return self.requestCurrentLocation()
        }.then { location in
            return CLGeocoder.reverseGeocode(location)
        }.then { placemark -> String in
            return placemark.subLocality;
        }
    }

    private struct Constants {
        static let AuthorizationType = CLLocationManager.RequestAuthorizationType.WhenInUse
        static let AuthorizationErrorCode = 0
    }

    class func requestCurrentLocation() -> Promise<CLLocation> {
        return CLLocationManager.promise(requestAuthorizationType: Constants.AuthorizationType)
    }

    class func requestAuthorizationWhenInUse() -> Promise<CLAuthorizationStatus> {
        let defer = Promise<CLAuthorizationStatus>.defer()

        CLLocationManager.requestAuthorization(type: Constants.AuthorizationType).then { status -> Void in
            switch status {
            case .AuthorizedWhenInUse:
                defer.fulfill(status)
            default:
                defer.reject(NSError(domain: "\(status)", code: Constants.AuthorizationErrorCode, userInfo: nil))
            }
        }

        return defer.promise;
    }
}