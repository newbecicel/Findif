//
//  FFStore.m
//  Findif
//
//  Created by Cicel Chen on 2018/9/9.
//  Copyright © 2018年 Cicel Chen. All rights reserved.
//

#import "FFStore.h"
#import "FFPublicFunc.h"
@implementation FFStore
+ (instancetype)storeWithDict:(NSDictionary *)dict
{
    FFStore *store = [self new];
    [store setValuesForKeysWithDictionary:dict];
    return store;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
+ (void)storeListWithSuccessBlock:(void (^)(NSArray *array))successBlock errorBlock:(void (^)(NSError *error))errorBlock
{
    
}
@end
