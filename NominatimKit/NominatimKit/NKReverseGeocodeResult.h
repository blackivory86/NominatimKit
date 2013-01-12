//
//  ReverseGeocodeResult.h
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKAddress.h"
#import "NominatimKit.h"

@interface NKReverseGeocodeResult : NSObject

@property long placeID;

@property OSMType osmType;

@property long osmID;

@property (strong) NSString* fullAddressString;

@property (strong) NKAddress* place;

@end
