//
//  NominatimRequest.h
//  NominatimKit
//
//  Created by Jan Rose on 31.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NominatimRequest : NSObject <NSURLConnectionDelegate>

@property (strong) NSURLConnection* connection;

@property (strong) NSMutableData* responseData;

- (void)handleFinishedLoading;

- (void)handleError:(NSError *)error;

- (void)startRequestWithURL:(NSURL*)url andTimeoutInterval:(long)timeout;

@end
