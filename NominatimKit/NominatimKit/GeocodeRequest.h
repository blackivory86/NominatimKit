//
//  GeocodeRequest.h
//  NominatimKit
//
//  Created by Jan Rose on 31.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NominatimRequest.h"
#import "NKGeocoder.h"

@interface GeocodeRequest : NominatimRequest

@property (strong) NKGeocodeCompletionHandler geocodeCompletionHandler;

@end
