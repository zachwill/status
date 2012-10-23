//
//  HRKIncrementalStore.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKIncrementalStore.h"
#import "HRKDataModel.h"

@implementation HRKIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

- (NSManagedObjectModel *)model {
    NSURL *dataModelURL = [[NSBundle mainBundle] URLForResource:[[HRKDataModel sharedModel] modelName]
                                                  withExtension:@"xcdatamodeld"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:dataModelURL];
}

- (id<AFIncrementalStoreHTTPClient>)HTTPClient {
#warning Missing API client
    return nil;
}

@end
