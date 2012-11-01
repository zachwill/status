//
//  Update.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Issue;

@interface Update : NSManagedObject

@property (nonatomic, retain) NSString * contents;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * update_type;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * status_dev;
@property (nonatomic, retain) NSString * status_prod;
@property (nonatomic, retain) NSNumber * incident_id;
@property (nonatomic, retain) NSNumber * update_id;
@property (nonatomic, retain) Issue *issue;

@end
