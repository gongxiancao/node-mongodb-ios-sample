//
//  ApiClient.h
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *s_serverUrl = @"http://localhost:3000/";

@interface ApiClient : NSObject

+ (void)get:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
