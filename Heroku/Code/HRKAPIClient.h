//
//  HRKAPIClient.h
//  Heroku
//
//  Created by Zach Williams on 10/23/12.
//  Copyright (c) 2012 Zach Williams. All rights reserved.
//

#import "AFRESTClient.h"

@interface HRKAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (HRKAPIClient *)sharedClient;
    
@end
