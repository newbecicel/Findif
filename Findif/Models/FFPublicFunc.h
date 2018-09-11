//
//  FFPublicFunc.h
//  Findif
//
//  Created by Cicel Chen on 2018/9/10.
//  Copyright © 2018年 Cicel Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFPublicFunc : NSObject
//获取当前时间戳
+(NSString *) timeStamp;

//特殊字符处理
+(NSString*)encodeURIComponent:(NSString*)str;

//字典转post请求体
+ (NSString *)paramStringFromParams:(NSDictionary *)params;

//加密方法的声明
+(NSString *) enCodeWithMd5:(NSDictionary *) enCode;

//请求数据的方法
+(NSDictionary *) getDateWithDict:(NSDictionary *)postDataDict postUrl:(NSString *) postUrl;




@end
