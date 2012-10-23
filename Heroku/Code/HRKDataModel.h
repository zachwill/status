//
//  HRKDataModel.h
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPersistentStoreCoordinator, NSManagedObjectContext;

@interface HRKDataModel : NSObject

@property (nonatomic, readonly) NSString *modelName;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext *mainContext;

+ (HRKDataModel *)sharedModel;
- (NSString *)pathToModel;
- (NSString *)storeFileName;
- (NSURL *)localStoreURL;
- (void)createSharedURLCache;

@end
