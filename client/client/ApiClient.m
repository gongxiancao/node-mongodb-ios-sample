//
//  ApiClient.m
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import "ApiClient.h"

@implementation ApiClient

+ (void)get:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    url = [s_serverUrl stringByAppendingString:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error) {
            NSLog(@"%@", error);
            if(failure) {
                failure(error);
            }
            return;
        }

        if(success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);

            dispatch_async(dispatch_get_main_queue(), ^{
                success(json);
            });
        }
    }];
    [dataTask resume];
}


+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    url = [s_serverUrl stringByAppendingString:url];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];

    NSError *jsonError;
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonError];
    [request setHTTPBody:data];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // handle response
        if(error) {
            NSLog(@"%@", error);
            if(failure) {
                failure(error);
            }
            return;
        }

        if(success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);
            dispatch_async(dispatch_get_main_queue(), ^{
                success(json);
            });
        }
    }];
    [postDataTask resume];
}

@end
