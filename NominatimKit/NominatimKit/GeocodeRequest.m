//
//  GeocodeRequest.m
//  NominatimKit
//
//  Created by Jan Rose on 31.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "GeocodeRequest.h"

@interface GeocodeRequest() <NSXMLParserDelegate>

@property (strong) NSMutableString* currentStringValue;

@property (strong) NSMutableArray* resultSet;

@end


@implementation GeocodeRequest

- (void)handleFinishedLoading
{
    NSLog(@"finished Loading");
    NSString* s = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", s);
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:self.responseData];
    [parser setDelegate:self];
    [parser parse];
    
    self.resultSet = [[NSMutableArray alloc] init];
}

- (void)handleError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{self.geocodeCompletionHandler(nil, error); } );
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [self handleError:parseError];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"parsing completed");
    dispatch_async(dispatch_get_main_queue(), ^{self.geocodeCompletionHandler(self.resultSet, nil); } );
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        self.currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [self.currentStringValue appendString:string];
}
@end
