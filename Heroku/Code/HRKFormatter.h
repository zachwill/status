//
//  HRKFormatter.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRKFormatter : NSObject

+ (HRKFormatter *)sharedFormatter;

- (NSDate *)dateFromString:(NSString *)dateString;

@end
