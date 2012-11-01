//
//  Issue.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Issue : NSManagedObject

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * href;
@property (nonatomic, retain) NSNumber * issue_id;
@property (nonatomic, retain) NSNumber * resolved;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * upcoming;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSSet *updates;
@end

@interface Issue (CoreDataGeneratedAccessors)

- (void)addUpdatesObject:(NSManagedObject *)value;
- (void)removeUpdatesObject:(NSManagedObject *)value;
- (void)addUpdates:(NSSet *)values;
- (void)removeUpdates:(NSSet *)values;

@end
