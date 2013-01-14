//
//  NKGeocoder.m
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NKGeocoder.h"

@interface NKGeocoder()

- (NSString*) buildParamsQueryString;

- (void) validateSettings;

@end

@implementation NKGeocoder

- (void) validateSettings
{
    NSString* errorMsgs = @"";
    if(!self.email){
        errorMsgs = [errorMsgs stringByAppendingString:@"email property must be set; "];
    }
    
    if(errorMsgs.length > 0){
        NSLog(@"there's an error-message available");
        [NSException raise:@"MissingSettings" format:@"%@", errorMsgs];
    }
}

#pragma mark forward Geocoding

- (void)geocodeQuery:(NSString *)query boundingBox:(NKBoundingBox)bbox limitToBoundingBox:(BOOL)limitToBox completionHandler:(NKGeocodeCompletionHandler)completionHandler{
    
    [self validateSettings];
}

- (void) geocodeStreet:(NSString *)street houseNumber:(NSString *)houseNumber city:(NSString *)city postCode:(NSString *)postCode county:(NSString *)county state:(NSString *)string country:(NSString *)country completionHandler:(NKGeocodeCompletionHandler)completionHandler{
    
    [self validateSettings];
}

#pragma mark Reverse Geocoding

- (void)reverseGeocodeLocation:(CLLocationCoordinate2D)location completionHandler:(NKReverseGeocodeCompletionHandler)completionHandler{
    
    [self validateSettings];
}

- (void)reverseGeocodeOsmID:(long)osmID ofType:(OSMType)type completionHandler:(NKReverseGeocodeCompletionHandler)completionHandler{
    [self validateSettings];
}

@end
