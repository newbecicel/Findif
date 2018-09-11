//
//  FFPublicFunc.m
//  Findif
//
//  Created by Cicel Chen on 2018/9/10.
//  Copyright © 2018年 Cicel Chen. All rights reserved.
//

#import "FFPublicFunc.h"
#import "NSString+Hash.h"

@implementation FFPublicFunc
//拼接参数并加密方法的实现


+ (NSString *)enCodeWithMd5:(NSDictionary *)enCode{
//排序
    //将所有的key放进数组
    NSArray *allKeyArray = [enCode allKeys];
    
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray  sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    
        
 
//    NSLog(@"排序后的key:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [enCode objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    NSString *sortStr = [valueArray componentsJoinedByString:@""];
    NSString *salt= @"NDQ0NTlmMDk4MTU3NTg3NzFiZTFlZmQwNDFjNzA0ZGMyYWY0NzU5ZQ==";
//    NSLog(@"排序后的values:%@",valueArray);
//    NSLog(@"排序候的拼接str:%@",sortStr);
    NSString *saltStr = [[NSString alloc] initWithFormat:@"%@%@",sortStr,salt];
//    NSLog(@"加盐后的字符串:%@",saltStr);
    saltStr = [saltStr md5String];
//    NSLog(@"md5后的字符串:%@",saltStr);
    NSData *data = [saltStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *signStr = [data base64EncodedStringWithOptions:0];
    NSLog(@"生成的签名:%@",signStr);
    return signStr;
}

+(NSDictionary *) getDateWithDict:(NSDictionary *)postDataDict postUrl:(NSString *)postUrl
{
    //加工参数post到服务器,接受到数据生成字典
    NSDictionary *dataDict ;
    
    
    //设置数据存储字典
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]initWithDictionary:postDataDict];
    NSLog(@"原始字典%@",postDict);
    [postDict setObject:[self timeStamp] forKey:@"timeStamp"];
    NSLog(@"添加时间的字典%@",postDict);
    {
    
       
        //获取网络数据
        NSURL * url = [NSURL URLWithString:postUrl];
        NSLog(@"请求的url:%@",postUrl);
        //设置缓存策略及超时时长
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
        //发送post请求
        request.HTTPMethod = @"post";
        //拼接请求体
//        NSDictionary *perProstbody =@{@"user_id":@"175",@"timeStamp":[self timeStamp]};
        NSString *sign =  [FFPublicFunc enCodeWithMd5:postDict];
        [postDict setObject:sign forKey:@"sign"];
        NSLog(@"准备提交的字典%@",postDict);
        
//        NSDictionary *postBody = @{@"user_id":@"175",@"timeStamp":[self timeStamp],@"sign":sign};
        
        //设置请求体
        
        request.HTTPBody = [[self paramStringFromParams:postDict] dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"发送的请求体1:%@",postDict);
        //开始连接
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if(connectionError){
                NSLog(@"连接错误:%@",connectionError);
                return ;
            }
            //判断是否正常接收到服务器返回的数据
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            
            if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
                //解析数据
                NSError *jsonError;
               NSDictionary *recDataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                NSLog(@"%@",recDataDict);
                //判断是否获取到json信息
                if(jsonError){
                    NSLog(@"解析JSON出错 %@",jsonError);
                    return;
                }
                //解析
//                NSLog(@"%@",dataDict);
//               return recDataDict;

            }else{
                NSLog(@"服务器内部错误");
            }
            
        }];
    
    }
    return dataDict;
}

//获取当前时间

+ (NSString *)timeStamp{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YY:MM:dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentTime];
    return dateString;
}


//转postDict字符
+ (NSString *)paramStringFromParams:(NSDictionary *)params{
    
    NSMutableString *returnValue = [[NSMutableString alloc]initWithCapacity:0];
    
    NSArray *paramsAllKeys = [params allKeys];
    
    for(int i = 0;i < paramsAllKeys.count;i++)
        
    {
        
        [returnValue appendFormat:@"%@=%@",[paramsAllKeys objectAtIndex:i],[self encodeURIComponent:[params objectForKey:[paramsAllKeys objectAtIndex:i]]]];
        
        if(i < paramsAllKeys.count - 1)
        {
            
            [returnValue appendString:@"&"];
            
        }
    }
    return returnValue;
}

+ (NSString*)encodeURIComponent:(NSString*)str{
    
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
}

@end
