//
//  Issue.h
//  Heroku
//
//  Created by Zach Williams on 11/1/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Update;

@interface Issue : NSManagedObject

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * href;
@property (nonatomic, retain) NSNumber * issue_id;
@property (nonatomic, retain) NSNumber * resolved;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * upcoming;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) id duration;
@property (nonatomic, retain) id day;
@property (nonatomic, retain) NSOrderedSet *updates;
@end

@interface Issue (CoreDataGeneratedAccessors)

- (void)insertObject:(Update *)value inUpdatesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromUpdatesAtIndex:(NSUInteger)idx;
- (void)insertUpdates:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeUpdatesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInUpdatesAtIndex:(NSUInteger)idx withObject:(Update *)value;
- (void)replaceUpdatesAtIndexes:(NSIndexSet *)indexes withUpdates:(NSArray *)values;
- (void)addUpdatesObject:(Update *)value;
- (void)removeUpdatesObject:(Update *)value;
- (void)addUpdates:(NSOrderedSet *)values;
- (void)removeUpdates:(NSOrderedSet *)values;
@end
