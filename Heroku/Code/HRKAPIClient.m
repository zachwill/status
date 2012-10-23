//
//  HRKAPIClient.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAPIClient.h"
#import <CoreData/CoreData.h>

static NSString * const kHerokuBaseURL = @"https://status.heroku.com/api/v3/issues";

@implementation HRKAPIClient

+ (HRKAPIClient *)sharedClient {
    static HRKAPIClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:kHerokuBaseURL];
        _sharedInstance = [[HRKAPIClient alloc] initWithBaseURL:url];
    });
    return _sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self)
        return nil;
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

#pragma mark - AFIncrementalStore

// Return the "objects" array from Tastypie API
- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    responseObject = [super representationOrArrayOfRepresentationsFromResponseObject:responseObject];
    NSArray *tastyPieObjects = [responseObject objectForKey:@"objects"];
    if ([responseObject isKindOfClass:[NSDictionary class]] && tastyPieObjects) {
        return tastyPieObjects;
    }
    return responseObject;
}

- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableRequest = nil;
    if ([fetchRequest.entityName isEqualToString:@"Drinkup"]) {
        mutableRequest = [self requestWithMethod:@"GET" path:@"drinkups" parameters:nil];
    }
    return mutableRequest;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutableProperties = [[super attributesForRepresentation:representation
                                                                        ofEntity:entity
                                                                    fromResponse:response] mutableCopy];
    return mutableProperties;
}

// Needs to be unique
- (NSString *)resourceIdentifierForRepresentation:(NSDictionary *)representation
                                         ofEntity:(NSEntityDescription *)entity
                                     fromResponse:(NSHTTPURLResponse *)response
{
#warning Needs to be unique
    return nil;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end
