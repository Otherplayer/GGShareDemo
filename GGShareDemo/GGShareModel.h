//
//  GGShareModel.h
//  GGShareDemo
//
//  Created by __无邪_ on 15/9/30.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGShareModel : NSObject

/// 共用参数
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *imageUrl;

@property (nonatomic, strong)NSString *thumbImageUrl;//微信

@property (nonatomic, strong)NSString *defaultContent;
@property (nonatomic, strong)NSString *desc;

@property (nonatomic, assign)NSInteger type;





@end
