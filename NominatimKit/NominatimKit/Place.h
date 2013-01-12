//
//  Place.h
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKPolygon>
#import "NominatimKit.h"

@interface Place : NSObject

@property long placeID;

@property OSMType osmType;

@property (strong) long osmID;

@property (strong) MKPolygon* polygon;

@property (strong) MKPolygon* boundingBox;

@property (strong) CLLocationCoordinate2D coordinate;

@property (strong) NSString* displayName;

@end
