//
//  HRKAPIClient.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAPIClient.h"
#import <CoreData/CoreData.h>

static NSString * const kHerokuBaseURL = @"https://status.heroku.com/api/v3/";

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

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return [super representationOrArrayOfRepresentationsFromResponseObject:responseObject];
}

- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableRequest = nil;
    if ([fetchRequest.entityName isEqualToString:@"Issue"]) {
        mutableRequest = [self requestWithMethod:@"GET" path:@"issues" parameters:@{@"limit": @30}];
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
    if ([entity.name isEqualToString:@"Issue"]) {
        mutableProperties[@"issue_id"] = representation[@"id"];
    }
    return mutableProperties;
}

- (NSString *)resourceIdentifierForRepresentation:(NSDictionary *)representation
                                         ofEntity:(NSEntityDescription *)entity
                                     fromResponse:(NSHTTPURLResponse *)response
{
    // Needs to be unique.
    return representation[@"href"];
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
