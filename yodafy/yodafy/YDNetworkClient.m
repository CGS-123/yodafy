//
//  YDNetworkClient.m
//  yodafy
//
//  Created by Colin Smith on 10/15/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import "YDNetworkClient.h"

@implementation YDNetworkClient

+ (YDNetworkClient *)sharedClient {
    static dispatch_once_t onceToken;
    static YDNetworkClient *sharedClient = nil;
    dispatch_once(&onceToken, ^{
        sharedClient = [YDNetworkClient new];
    });
    return sharedClient;
}

- (void)getYodafiedResponseWithString:(NSString *)yodaString success:(void(^)(NSString *yodaString))success failure:(void(^)(NSError *))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *updatedYodaString = [yodaString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString *urlString = [NSString stringWithFormat:@"https://yoda.p.mashape.com/yoda?sentence=%@", updatedYodaString];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"bUEe3HgbixmshlPGPDIIke4u56XSp1NszgNjsnpoqYUnAJhjoj" forHTTPHeaderField:@"X-Mashape-Key"];
        [request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
        [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *newYodaString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (newYodaString && !error) {
                    if (success) {
                        success(newYodaString);
                    }
                } else {
                    if (failure) {
                        failure(error);
                    }
                }
            });
        }] resume];
    });
}

@end
