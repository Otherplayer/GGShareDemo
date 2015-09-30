//
//  GGShareManager.m
//  GGShareDemo
//
//  Created by __无邪_ on 15/9/30.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "GGShareManager.h"

@implementation GGShareManager

+ (instancetype)sharedInstance{
    static GGShareManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GGShareManager alloc] init];
    });
    return manager;
}




#pragma mark - share action

- (void)shareWeibo{
    [self shareContentWithType:ShareTypeSinaWeibo];
}

- (void)shareQQ{
    [self shareContentWithType:ShareTypeQQ];
}

- (void)shareQQSpace{
    [self shareContentWithType:ShareTypeQQSpace];
}

- (void)shareWeChat{
    [self shareContentWithType:ShareTypeWeixiSession];
}

- (void)shareWeChatTimeLine{
    [self shareContentWithType:ShareTypeWeixiTimeline];
}

- (void)shareSMS{
    [self shareContentWithType:ShareTypeSMS];
}


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - private



- (BOOL)isQQInstalled{
    if ([QQApi isQQInstalled] && [QQApi isQQSupportApi]) {
        return YES;
    }
    return NO;
}

- (BOOL)isWeChatInstalled{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        return YES;
    }
    return NO;
}


// 分享
- (void)shareContentWithType:(ShareType)type {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    id<ISSContent> publishContent = [self publicContentWithImage:[ShareSDK imageWithPath:imagePath]];;
    
    
    
    switch (type) {
        case ShareTypeQQ:{
            //定制QQ分享信息
            [publishContent addQQUnitWithType:[NSNumber numberWithInt:SSPublishContentMediaTypeNews]
                                      content:@"Otherplayer"
                                        title:@"标题title"
                                          url:@"www.baidu.com"
                                        image:[ShareSDK imageWithPath:imagePath]];
        }
            break;
        case ShareTypeQQSpace:{
            //定制QQ空间分享
            [publishContent addQQSpaceUnitWithTitle:@"标题"
                                                url:@"www.baidu.com"
                                               site:nil
                                            fromUrl:nil
                                            comment:INHERIT_VALUE
                                            summary:@"Otherplayer"
                                              image:[ShareSDK imageWithPath:imagePath]
                                               type:INHERIT_VALUE
                                            playUrl:nil
                                               nswb:nil];
        }
            break;
        case ShareTypeWeixiSession:{
            //定制微信朋友圈
            [publishContent addWeixinSessionUnitWithType:[NSNumber numberWithInt:SSPublishContentMediaTypeNews]
                                                 content:@"Otherplayer"
                                                   title:@"标题title"
                                                     url:@"www.baidu.com"
                                              thumbImage:[ShareSDK imageWithPath:imagePath]
                                                   image:[ShareSDK imageWithPath:imagePath]
                                            musicFileUrl:nil
                                                 extInfo:nil
                                                fileData:nil
                                            emoticonData:nil];
        }
            break;
        case ShareTypeWeixiTimeline:{
            //定制微信朋友圈信息
            [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                                  content:@"Otherplayer"
                                                    title:@"标题title"
                                                      url:@"www.baidu.com"
                                               thumbImage:[ShareSDK imageWithPath:imagePath]
                                                    image:[ShareSDK imageWithPath:imagePath]
                                             musicFileUrl:nil
                                                  extInfo:nil
                                                 fileData:nil
                                             emoticonData:nil];
        }
            break;
        case ShareTypeSMS:{
            //定制短信信息
            [publishContent addSMSUnitWithContent:@"Otherplayer"
                                          subject:nil
                                      attachments:nil
                                               to:nil];
        }
            break;
        default:{
            //构造分享内容
            publishContent = [ShareSDK content:@"Otherplayer"
                                defaultContent:@"__无邪_"
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@"标题title"
                                           url:@"www.baidu.com"
                                   description:@"测试微博"
                                     mediaType:SSPublishContentMediaTypeImage];
        }
            break;
    }
    
    [self shareAction:type content:publishContent];
}



- (void)shareAction:(ShareType)type content:(id<ISSContent>)publishContent{
    
    [ShareSDK clientShareContent:publishContent type:type statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSPublishContentStateSuccess){
            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
        }else{
            NSLog(@"Error: %@",error.errorDescription);
        }
    }];
    
}


-(id<ISSContent>)publicContentWithImage:(id<ISSCAttachment>)attachImage{
    return  [ShareSDK content:nil
               defaultContent:nil
                        image:attachImage
                        title:nil
                          url:nil
                  description:nil
                    mediaType:SSPublishContentMediaTypeNews];
}




////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - configure
- (void)registerConfigure{
    [ShareSDK registerApp:kShareSDKAppKey];//字符串api20为您的ShareSDK的AppKey
    
    [self configureSinaWeibo];
    [self configureQQ];
    [self configureWeChat];
    [self configureSMS];
}

///新浪微博分享
- (void)configureSinaWeibo{
    //添加新浪微博应用 注册网址 http://open.weibo.com
    
    [ShareSDK connectSinaWeiboWithAppKey:kSinaWeiboAppKey
                               appSecret:kSinaWeiboAppSecret
                             redirectUri:@"http://www.hotyq.com"];
    /********************************************
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http:www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
     *******************************************/
    
}

- (void)configureQQ{
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    
    [ShareSDK connectQZoneWithAppKey:kQQSpaceAppKey
                           appSecret:kQQSpaceAppSecret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    
    [ShareSDK connectQQWithQZoneAppKey:kQQSpaceAppKey
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
}
///微信分享:好友，朋友圈
- (void)configureWeChat{
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    
    /********************************************
     //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
     *******************************************/
    
    //微信好友
    [ShareSDK connectWeChatSessionWithAppId:kWechatAppKey
                                  appSecret:kWechatAppSecret
                                  wechatCls:[WXApi class]];
    
    //朋友圈
    [ShareSDK connectWeChatTimelineWithAppId:kWechatAppKey
                                   appSecret:kWechatAppSecret
                                   wechatCls:[WXApi class]];
    
}

- (void)configureSMS{
    [ShareSDK connectSMS];
}


@end
