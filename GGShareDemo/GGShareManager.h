//
//  GGShareManager.h
//  GGShareDemo
//
//  Created by __无邪_ on 15/9/30.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGShareConfiguration.h"
#import "GGShareModel.h"

@interface GGShareManager : NSObject

+ (instancetype)sharedInstance;
- (void)registerConfigure;



- (void)shareWeibo;
- (void)shareQQ;
- (void)shareQQSpace;
- (void)shareWeChat;
- (void)shareWeChatTimeLine;
- (void)shareSMS;



- (BOOL)isQQInstalled;
- (BOOL)isWeChatInstalled;


@end
