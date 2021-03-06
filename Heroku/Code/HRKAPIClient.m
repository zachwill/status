//
//  HRKAPIClient.m
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "HRKAPIClient.h"
#import <CoreData/CoreData.h>

// ***************************************************************************

static NSString * const kHerokuBaseURL = @"https://status.heroku.com/api/v3/";

static NSDate * HRKISO8601DateFormatter(NSString *string) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    return [formatter dateFromString:string];
}

// ***************************************************************************

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
        mutableRequest = [self requestWithMethod:@"GET" path:@"issues" parameters:@{@"limit": @20}];
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

    // Created and updated times.
    NSDate *created, *updated;
    if ([entity.name isEqualToString:@"Issue"] || [entity.name isEqualToString:@"Update"]) {
        created = HRKISO8601DateFormatter(representation[@"created_at"]);
        mutableProperties[@"created_at"] = created;
        updated = HRKISO8601DateFormatter(representation[@"updated_at"]);
        mutableProperties[@"updated_at"] = updated;
    }

    // Unique properties to each entity.
    if ([entity.name isEqualToString:@"Issue"]) {
        mutableProperties[@"issue_id"]   = representation[@"id"];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *duration = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:created toDate:updated options:0];
        mutableProperties[@"duration"] = duration;
        // Used for sections.
        unsigned int dayOptions = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
        NSDate *day = [calendar dateFromComponents:[calendar components:dayOptions fromDate:created]];
        mutableProperties[@"day"] = day;
    } else if ([entity.name isEqualToString:@"Update"]) {
        mutableProperties[@"update_id"]  = representation[@"id"];
    }

    return mutableProperties;
}

- (NSString *)resourceIdentifierForRepresentation:(NSDictionary *)representation
                                         ofEntity:(NSEntityDescription *)entity
                                     fromResponse:(NSHTTPURLResponse *)response
{
    // Needs to be unique.
    if ([entity.name isEqualToString:@"Issue"]) {
        return representation[@"href"];
    }
    return [representation[@"id"] description];
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
