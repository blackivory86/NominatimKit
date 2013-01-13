//
//  NKGeocoder.m
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NKGeoBoundingBox.h"

NKBoundingBox NKBoundingBoxMake(CLLocationCoordinate2D topleft, CLLocationCoordinate2D bottomRight) {
    NKBoundingBox box;
    box.topLeft = topleft;
    box.bottomRight = bottomRight;
    return box;
}
