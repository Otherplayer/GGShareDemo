//
//  ViewController.m
//  GGShareDemo
//
//  Created by __无邪_ on 15/9/30.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "GGShareManager.h"
@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareAction:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"share demo" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [sheet addButtonWithTitle:@"QQ"];
    [sheet addButtonWithTitle:@"QQSpace"];
    [sheet addButtonWithTitle:@"WeChat"];
    [sheet addButtonWithTitle:@"Timeline"];
    [sheet addButtonWithTitle:@"Weibo"];
    [sheet addButtonWithTitle:@"SMS"];
    
    [sheet showInView:self.view.window];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld",buttonIndex);
    
    if (buttonIndex == 1) {
        [[GGShareManager sharedInstance] shareQQ];
    }else if (buttonIndex == 2){
        [[GGShareManager sharedInstance] shareQQSpace];
    }else if (buttonIndex == 3){
        [[GGShareManager sharedInstance] shareWeChat];
    }else if (buttonIndex == 4){
        [[GGShareManager sharedInstance] shareWeChatTimeLine];
    }else if (buttonIndex == 5){
        [[GGShareManager sharedInstance] shareWeibo];
    }else if (buttonIndex == 6){
        [[GGShareManager sharedInstance] shareSMS];
    }
    

}





@end
