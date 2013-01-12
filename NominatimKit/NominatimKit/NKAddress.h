//
//  Place.h
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKAddress : NSObject

@property (strong) NSString* houseNumber;

@property (strong) NSString* street;

@property (strong) NSString* village;

@property (strong) NSString* town;

@property (strong) NSString* city;

@property (strong) NSString* county;

@property (strong) NSString* postCode;

@property (strong) NSString* country;

@property (strong) NSString* countryCode;

@end
