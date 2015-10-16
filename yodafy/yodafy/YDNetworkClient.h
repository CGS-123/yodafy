//
//  YDNetworkClient.h
//  yodafy
//
//  Created by Colin Smith on 10/15/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDNetworkClient : NSObject

+ (YDNetworkClient *)sharedClient;

- (void)getYodafiedResponseWithString:(NSString *)string success:(void(^)(NSString *yodaString))success failure:(void(^)(NSError *))failure;

@end
