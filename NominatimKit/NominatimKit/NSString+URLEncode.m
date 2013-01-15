//
//  NSString+URLEncode.m
//  NominatimKit
//
//  Created by Jan Rose on 15.01.13.
//  Copyright (c) 2013 Jan Rose. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

- (NSString*) stringByURLEncodingString
{
    NSString * encodedString = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}

@end
