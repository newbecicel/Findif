//
//  FFStore.h
//  Findif
//
//  Created by Cicel Chen on 2018/9/9.
//  Copyright © 2018年 Cicel Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFStore : NSObject

@property (nonatomic,copy) NSString *store_id;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *timeStamp;
@property (nonatomic,copy) NSString *sign;

+ (instancetype)storeWithDict:(NSDictionary *)dict;
+ (void)storeListWithSuccessBlock:(void (^)(NSArray *array))successBlock errorBlock:(void (^)(NSError *error))errorBlock;
@end
