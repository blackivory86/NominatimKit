//
//  NKGeoBoundingBox.h
//  NominatimKit
//
//  Created by Jan Rose on 12.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef struct {
    CLLocationCoordinate2D topLeft;
    CLLocationCoordinate2D bottomRight;
} NKGeoBoundingBox;
