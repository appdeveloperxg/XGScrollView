//
//  ViewController.m
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "ViewController.h"
#import "XGImageScrollView.h"
@interface ViewController ()<XGScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSMutableArray * arr =[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++) {
        
        NSString * str =[NSString stringWithFormat:@"引导图%d_320_480",i+1];
        [arr addObject:str];
        
    }
    
    XGImageScrollView * scrollView = [[XGImageScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 400)];
    scrollView.ImageArray = arr;
    scrollView.xg_delegate = self;
    scrollView.isBroser = NO;//是否循环播放
    scrollView.controller = self;
    [scrollView setDataArray:arr];//
    scrollView.broser.numLable.hidden = YES;//数字lable 是否隐蔽
    [self.view addSubview:scrollView];
    
    
    
    NSLog(@"Yellow");
}
#pragma mark-- xg_scrollView deledate
-(void)didClickXGImageScrollView:(id)object
{
    UIScrollView * scrollView = (UIScrollView*)object;
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%zi",point);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
