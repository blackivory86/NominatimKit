//
//  NKGeocoder.h
//  NominatimKit
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NominatimKit.h"
#import "NKReverseGeocodeResult.h"
#import "NKGeoBoundingBox.h"

typedef void (^NKGeocodeCompletionHandler)(NSArray *places, NSError *error);

typedef void (^NKReverseGeocodeCompletionHandler)(NKReverseGeocodeResult* result, NSError *error);

@interface NKGeocoder : NSObject

#pragma mark forward Geocoding

- (void)geocodeQuery:(NSString*)query
         boundingBox:(NKBoundingBox)bbox
  limitToBoundingBox:(BOOL)limitToBox
   completionHandler:(NKGeocodeCompletionHandler)completionHandler;

/**
 Alternative query string format for structured requests.  Structured requests are faster and require
 less resource server resources.
 */
- (void)geocodeStreet:(NSString*)street
          houseNumber:(NSString*)houseNumber
                 city:(NSString*)city
             postCode:(NSString*)postCode
               county:(NSString*)county
                state:(NSString*)string
              country:(NSString*)country
    completionHandler:(NKGeocodeCompletionHandler)completionHandler;

#pragma mark Reverse Geocoding

- (void)reverseGeocodeLocation:(CLLocationCoordinate2D)location completionHandler:(NKReverseGeocodeCompletionHandler)completionHandler;

- (void)reverseGeocodeOsmID:(long)osmID ofType:(OSMType)type completionHandler:(NKReverseGeocodeCompletionHandler)completionHandler;


#pragma mark Geocoding process management

- (void)cancelGeocode;

@property (nonatomic, readonly, getter=isGeocoding) BOOL geocoding;

#pragma mark Query settings

/**
 Level of detail required for the result. 0 is country and 18 is house/building
 */
@property unsigned short levelOfDetail;

/**
 breakdown of the address into elements
 */
@property BOOL enableAddressDetails;

/**
 If you are making large numbers of request please include a valid email address
 or alternatively include your email address as part of the User-Agent string.
 This information will be kept confidential and only used to contact you in the
 event of a problem, see Nominatim Usage Policy for more details.
 */
@property (strong) NSString* email;

/**
 Preferred language order for showing search results, overrides the browser value.
 Either uses standard rfc2616 accept-language string or a simple comma separated list of language codes.
 */
@property (strong) NSString* acceptLanguage;

/**
 Limit the number of returned results for forward geocoding
 */
@property unsigned int maxResults;

/**
 Output polygon outlines for items found
 */
@property BOOL returnPolygons;


/**
 Limit search results to a specific country (or a list of countries).  <countrycode> should be the ISO 3166-1
 alpha2 code, e.g. gb for the uk, de for germany, etc.
 */
@property (strong) NSArray* allowedCountries;

@property long timeoutInterval;

/**
 Set the baseURL of the nominatim server used for all querys
 */
+ (void) setNominatimServerURL:(NSString*)serverURL;

/**
 get the previously set URL of the nominatim server
 */
+ (NSString*) nominatimServerURL;


@end
