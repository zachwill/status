//
//  HRKFormatter.m
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKFormatter.h"

@implementation HRKFormatter

+ (HRKFormatter *)sharedFormatter {
    static HRKFormatter *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HRKFormatter alloc] init];
    });
    return _sharedInstance;
}

- (NSDate *)dateFromString:(NSString *)dateString {
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [_dateFormatter dateFromString:dateString];
}

@end
