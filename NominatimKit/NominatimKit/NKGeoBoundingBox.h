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
} NKBoundingBox;

NKBoundingBox NKBoundingBoxMake(CLLocationCoordinate2D topleft, CLLocationCoordinate2D bottomRight);

#define NKLocationCoordinate2DNull CLLocationCoordinate2DMake(-360.0, -360.0)

#define NKBoundingBoxNull NKBoundingBoxMake(NKLocationCoordinate2DNull,NKLocationCoordinate2DNull)

