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

BOOL NKBoundingBoxIsValid(NKBoundingBox bbox)
{
    //Coordinates valid
    if( !CLLocationCoordinate2DIsValid(bbox.topLeft) )
        return NO;
    if( !CLLocationCoordinate2DIsValid(bbox.bottomRight) )
        return NO;
    
    //bottomRight and topLeft actually bottom/top and left/right and not the other way round
    if(bbox.topLeft.longitude > bbox.bottomRight.longitude)
        return NO;
    if(bbox.topLeft.latitude < bbox.bottomRight.latitude)
        return NO;
    
    return YES;
}