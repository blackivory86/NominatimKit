//
//  NominatimKitTests.m
//  NominatimKitTests
//
//  Created by Jan Rose on 11.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NominatimKitTests.h"

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

@end
