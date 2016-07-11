//
//  ViewController.m
//  XGScrollView
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "ViewController.h"
#import "PickerButton.h"
#import "ToolBarButton.h"
#import "IndicatorButton.h"
@interface ViewController ()<ToolBarButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * arr =@[@"Love",@"You",@"Happy",@"Good"];
    //========================
    PickerButton * btn =[[PickerButton alloc]initWithItemList:arr];
    btn.frame = CGRectMake(100, 100, 100, 100);


//    btn.backgroundColor = [UIColor redColor];
//    UIImage *image = [UIImage newImageFromResource:@"down_icon.png"];
//    [btn setBackgroundImage:image
//                                forState:UIControlStateNormal];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitle:@"hallow" forState:UIControlStateNormal];
    btn.isShowSelectItemOnButton = YES;
    [self.view addSubview:btn];

    /*!
     =======================
     */
    ToolBarButton * button = [[ToolBarButton alloc]initWithFrame:CGRectMake(50, 275, 220, 40)];
    button.activeBgColor = [UIColor magentaColor];
    button.nomalBgColor = [UIColor yellowColor];
    button.delegate = self;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_default.png"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_button_canjia_pressed.png"] forState:UIControlStateHighlighted];
    [button setTitle:@"hallow" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    /*!
     */
    IndicatorButton * _timeButton = [[IndicatorButton alloc] initWithFrame:CGRectMake(100, 360, 200, 30)];
    
    [_timeButton setTitle:@"chooseTime" forState:UIControlStateNormal];
    
    [_timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _timeButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
    
    _timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _timeButton.backgroundColor = [UIColor redColor];
    
    _timeButton.enabled = NO;
    
    _timeButton.isIndicatorUp = YES;
    
    _timeButton.indicatorIconView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_timeButton];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
