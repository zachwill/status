//
//  Issue.h
//  Heroku
//
//  Created by Zach Williams on 10/31/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Issue : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * href;
@property (nonatomic, retain) NSNumber * resolved;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSNumber * upcoming;
@property (nonatomic, retain) NSNumber * issue_id;

@end
