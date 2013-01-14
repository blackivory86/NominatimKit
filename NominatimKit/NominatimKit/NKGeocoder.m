//
//  NKGeocoder.m
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NKGeocoder.h"

@interface NKGeocoder()

- (NSString*) buildGeneralParamsQueryString;

- (NSString*) buildGeocodeParamsQueryString;

- (NSString*) buildReverseGeocodeParamsQueryString;

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

- (NSString*) buildGeneralParamsQueryString
{
    NSString* queryParamStr = nil;
    NSString* newQuery = nil;
    
    //Output format
    queryParamStr = [@"format=" stringByAppendingString:@"xml"];
    
    //Accept-Language
    if(self.acceptLanguage){
        newQuery = [@"accept-language=" stringByAppendingString:self.acceptLanguage];
        queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    }
    
    //Split Address into single parts
    if (self.enableAddressDetails) {
        newQuery = [@"addressdetails=" stringByAppendingString:@"1"];
    } else {
        newQuery = [@"addressdetails=" stringByAppendingString:@"0"];
    }
    queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    
    return queryParamStr;
}

- (NSString*) buildGeocodeParamsQueryString{
    NSString* queryParamStr = [self buildGeneralParamsQueryString];
    NSString* newQuery = nil;
    
    //Limit maximum number of results
    if(self.maxResults > 0){
        newQuery = [@"limit=" stringByAppendingFormat:@"%u", self.maxResults];
        queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    }
    
    //Get Polygon outlines - or don't get them
    if (self.returnPolygons) {
        newQuery = [@"polygon=" stringByAppendingString:@"1"];
    } else {
        newQuery = [@"polygon=" stringByAppendingString:@"0"];
    }
    queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    
    return queryParamStr;
}

- (NSString*) buildReverseGeocodeParamsQueryString
{
    NSString* queryParamStr = [self buildGeneralParamsQueryString];
    NSString* newQuery = nil;
    
    //Limit maximum number of results
    if(self.levelOfDetail > 0 && self.levelOfDetail < 18){
        newQuery = [@"zoom=" stringByAppendingFormat:@"%uh", self.levelOfDetail];
        queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    }
    
    //Get Polygon outlines - or don't get them
    if (self.returnPolygons) {
        newQuery = [@"polygon=" stringByAppendingString:@"1"];
    } else {
        newQuery = [@"polygon=" stringByAppendingString:@"0"];
    }
    queryParamStr = [queryParamStr stringByAppendingFormat:@"&%@", newQuery];
    
    return queryParamStr;
}



#pragma mark forward Geocoding

- (void)geocodeQuery:(NSString *)query boundingBox:(NKBoundingBox)bbox limitToBoundingBox:(BOOL)limitToBox completionHandler:(NKGeocodeCompletionHandler)completionHandler{
    
    //Check if email is set
    [self validateSettings];
    
    //TODO: check if there's still a thread running
    
    //Build query string
    NSString* url = [NKGeocoder nominatimServerURL];
    url = [url stringByAppendingString:@"search?"];
    
    //Query-String
    if(query && query.length > 0){
        //TODO:
        NSLog(@"TODO: HTML-escape the query string");
        url = [url stringByAppendingFormat:@"q=%@",query];
    } else {
        //TODO: call completion hangler with error
    }
    
    //BoundingBox
    if(NKBoundingBoxIsValid(bbox)){
        url = [url stringByAppendingFormat:@"&viewbox=%f,%f,%f,%f", bbox.topLeft.longitude, bbox.topLeft.latitude, bbox.bottomRight.longitude, bbox.bottomRight.latitude];
    }
    
    //Limit to BB?
    if(limitToBox){
        url = [url stringByAppendingString:@"&bounded=1"];
    } else {
        url = [url stringByAppendingString:@"&bounded=0"];
    }
    
    //Set all other params
    NSString* otherParams = [self buildGeocodeParamsQueryString];
    url = [url stringByAppendingString:otherParams];
    
    
    
    //TODO: start query
    
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
