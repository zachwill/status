//
//  HRKDataModel.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKDataModel.h"
#import <CoreData/CoreData.h>
#import "AFIncrementalStore.h"
#import "HRKIncrementalStore.h"

@interface HRKDataModel ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readwrite) NSManagedObjectContext *mainContext;

- (NSURL *)documentsDirectory;
- (NSString *)persistentStoreType;

@end


@implementation HRKDataModel

+ (HRKDataModel *)sharedModel {
    static HRKDataModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HRKDataModel alloc] init];
    });
    return _sharedInstance;
}

- (NSString *)pathToModel {
    NSString *model = @"mom";
    NSString *directory = @"momd";
    NSString *path = [[NSBundle mainBundle] pathForResource:self.modelName ofType:model];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:self.modelName ofType:directory];
    }
    return path;
}

- (NSString *)storeFileName {
    return [self.modelName stringByAppendingPathExtension:@"sqlite"];
}

- (NSURL *)localStoreURL {
    return [[self documentsDirectory] URLByAppendingPathComponent:[self storeFileName]];
}

# pragma mark - Private Methods

- (NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)persistentStoreType {
    return [HRKIncrementalStore type];
}

// NOTE: Should only be set once.
- (void)createSharedURLCache {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUInteger memory = 8 * 1024 * 1024;
        NSUInteger disk   = 20 * 1024 * 1024;
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:memory diskCapacity:disk diskPath:nil];
        [NSURLCache setSharedURLCache:cache];
    });
}

#pragma mark - Getters

- (NSString *)modelName {
    return @"Heroku";
}

- (NSManagedObjectContext *)mainContext {
    if (_mainContext != nil) {
        return _mainContext;
    }

    _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _mainContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    return _mainContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }

    NSURL *storeURL = [NSURL fileURLWithPath:[self pathToModel]];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *storeType = [self persistentStoreType];
    AFIncrementalStore *store = (AFIncrementalStore *)[_persistentStoreCoordinator addPersistentStoreWithType:storeType
                                                                                                configuration:nil URL:nil
                                                                                                      options:nil error:nil];
    NSDictionary *options = @{
        NSInferMappingModelAutomaticallyOption: @YES,
        NSMigratePersistentStoresAutomaticallyOption: @YES
    };

    NSError *error;
    [store.backingPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                          configuration:nil
                                                                    URL:[self localStoreURL]
                                                                options:options
                                                                  error:&error];

    if (error) {
        // Should probably abort, as well?
        NSLog(@"Persistent store error %@, %@", error, [error userInfo]);
    }

    NSLog(@"SQLITE: %@", [self localStoreURL]);
    return _persistentStoreCoordinator;
}

@end
