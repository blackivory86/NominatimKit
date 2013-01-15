//
//  NominatimKitTests.m
//  NominatimKitTests
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NominatimKitTests.h"
#import "SenTestingKitAsync.h"

#import "NKGeocoder.h"

@implementation NominatimKitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSettingsValidation
{
    NKGeocoder* coder = [[NKGeocoder alloc] init];
    
    STAssertThrows([coder geocodeQuery:@"Hamburger Allee" boundingBox:NKBoundingBoxNull limitToBoundingBox:YES completionHandler:nil], @"validation should have failed - no email is set");
    
    STAssertThrows([coder geocodeStreet:@"Hagemannstraße" houseNumber:@"12" city:@"Hildesheim" postCode:@"31137" county:nil state:nil country:@"Germany" completionHandler:nil], @"validation should have failed - no email is set");
    
    STAssertThrows([coder reverseGeocodeLocation:CLLocationCoordinate2DMake(0.0, 0.0) completionHandler:nil], @"validation should have failed - no email is set");
    
    STAssertThrows([coder reverseGeocodeOsmID:000 ofType:Node completionHandler:nil], @"validation should have failed - no email is set");
    
    coder.email = @"testadress@nominatimkit.com";
    
    STAssertNoThrowSpecificNamed([coder geocodeQuery:@"Hamburger Allee" boundingBox:NKBoundingBoxNull limitToBoundingBox:YES completionHandler:nil], NSException, @"MissingSettings", @"Email is set - should not throw MissingSettings Exception");
    
    STAssertNoThrowSpecificNamed([coder geocodeStreet:@"Hagemannstraße" houseNumber:@"12" city:@"Hildesheim" postCode:@"31137" county:nil state:nil country:@"Germany" completionHandler:nil], NSException, @"MissingSettings", @"Email is set - should not throw MissingSettings Exception");
    
    STAssertNoThrowSpecificNamed([coder reverseGeocodeLocation:CLLocationCoordinate2DMake(0.0, 0.0) completionHandler:nil], NSException, @"MissingSettings", @"Email is set - should not throw MissingSettings Exception");
    
    STAssertNoThrowSpecificNamed([coder reverseGeocodeOsmID:000 ofType:Node completionHandler:nil],NSException, @"MissingSettings", @"Email is set - should not throw MissingSettings Exception");
}

- (void)testGeocodeQueryFailWithEmptyQuery
{
    NKGeocoder* coder = [[NKGeocoder alloc] init];
    coder.email = @"testadress@nominatimkit.com";
    [NKGeocoder setNominatimServerURL:@"http://nominatim.openstreetmap.org"];
    
    [coder geocodeQuery:nil boundingBox:NKBoundingBoxNull limitToBoundingBox:NO completionHandler:^(NSArray *places, NSError *error) {
        STAssertNotNil(error, @"should return without error");
        STAssertNil(places, @"returned array should not be nil");
    }];
    
    STFailAfter(1, @"Method should have returned immediately");
    
    [coder geocodeQuery:@"" boundingBox:NKBoundingBoxNull limitToBoundingBox:NO completionHandler:^(NSArray *places, NSError *error) {
        STAssertNotNil(error, @"should return without error");
        STAssertNil(places, @"returned array should not be nil");
    }];
    
    STFailAfter(1, @"Method should have returned immediately");
}

- (void)testGeocodeQueryReturnsSuccessfull
{
    NKGeocoder* coder = [[NKGeocoder alloc] init];
    coder.email = @"testadress@nominatimkit.com";
    [NKGeocoder setNominatimServerURL:@"http://nominatim.openstreetmap.org"];
    
    [coder geocodeQuery:@"Hagemannstraße 20" boundingBox:NKBoundingBoxNull limitToBoundingBox:NO completionHandler:^(NSArray *places, NSError *error) {
        STAssertNil(error, @"should return without error");
        STAssertNotNil(places, @"returned array should not be nil");
    }];
    
    STFailAfter(60, @"Method should have returned after 60 seconds");
}

@end
