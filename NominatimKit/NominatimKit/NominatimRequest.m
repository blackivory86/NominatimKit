//
//  NominatimRequest.m
//  NominatimKit
//
//  Created by Jan Rose on 31.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NominatimRequest.h"

@implementation NominatimRequest

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d
{
    [self.responseData appendData:d];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self handleFinishedLoading];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", [error localizedDescription]);
    self.responseData = nil;
    
    [self handleError:error];
}

- (void)connection:(NSURLConnection *)con didReceiveResponse:(NSURLResponse *)response
{
    if( ((NSHTTPURLResponse*)response).statusCode == 200) {
        //Preinstantiate object for response-data
        int responseSize = response.expectedContentLength;
        responseSize = (responseSize < 10000 && responseSize > 0) ? responseSize : 1000;
        NSLog(@"responseSize: %d", responseSize);
        self.responseData = [NSMutableData dataWithCapacity:responseSize];
    } else {
        //TODO: handle other response-types
    }
}

- (void)startRequestWithURL:(NSURL*)url andTimeoutInterval:(long)timeout
{
    NSURLRequest* req = [NSURLRequest requestWithURL:url
                                         cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                     timeoutInterval:timeout];
    self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
    NSLog(@"starting request with URL: %@", [url path]);
    [self.connection start];
}

@end
