//
//  ViewController.m
//  Findif
//
//  Created by Cicel Chen on 2018/9/9.
//  Copyright © 2018年 Cicel Chen. All rights reserved.
//

#import "ViewController.h"
#import "FFPublicFunc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSDictionary *data = [FFPublicFunc getDateWithDict:@{@"user_id":@"175"} postUrl:@"https://findif.cn/Api/MerchantsList"];
    NSLog(@"最终接收到的数据%@",data);
//    [self loadStore];
    
}
//发送异步请求获取数据
//-(void) loadStore
//{
//
//    //获取网络数据
//    NSURL * url = [NSURL URLWithString:@"https://findif.cn/Api/MerchantsList"];
//    //设置缓存策略及超时时长
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
//    //发送post请求
//    request.HTTPMethod = @"post";
//    //拼接请求体
//    NSDictionary *perProstbody =@{@"user_id":@"175",@"timeStamp":[self timeStamp]};
//    NSString *sign =  [FFPublicFunc enCodeWithMd5:perProstbody];
//    NSDictionary *postBody = @{@"user_id":@"175",@"timeStamp":[self timeStamp],@"sign":sign};
//
//    //设置请求体
//
//    request.HTTPBody = [[self paramStringFromParams:postBody] dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"发送的请求体%@",request.HTTPBody);
//    //开始连接
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if(connectionError){
//            NSLog(@"连接错误:%@",connectionError);
//            return;
//        }
//            //判断是否正常接收到服务器返回的数据
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//
//        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
//            //解析数据
//            NSError *jsonError;
//           id jsonOfStore = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            //判断是否获取到json信息
//            if(jsonError){
//                NSLog(@"解析JSON出错 %@",jsonError);
//                return;
//            }
//            //解析
//            NSLog(@"%@",jsonOfStore);
//
//
//        }else{
//            NSLog(@"服务器内部错误");
//        }
//    }];
//}
//
////获取当前时间戳
//-(NSString *) timeStamp{
//    NSDate *currentTime = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"YY:MM:dd HH:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:currentTime];
//    return dateString;
//}
////字典转post请求体
//- (NSString *)paramStringFromParams:(NSDictionary *)params{
//
//    NSMutableString *returnValue = [[NSMutableString alloc]initWithCapacity:0];
//
//    NSArray *paramsAllKeys = [params allKeys];
//
//    for(int i = 0;i < paramsAllKeys.count;i++)
//
//    {
//
//[returnValue appendFormat:@"%@=%@",[paramsAllKeys objectAtIndex:i],[self encodeURIComponent:[params objectForKey:[paramsAllKeys objectAtIndex:i]]]];
//
//if(i < paramsAllKeys.count - 1)
//{
//
//    [returnValue appendString:@"&"];
//
//}
//}
//return returnValue;
//}
//
//
////特殊字符处理
//
//-(NSString*)encodeURIComponent:(NSString*)str{
//
//    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
//
//}


@end
