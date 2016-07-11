//
//  XGBroserView.h
//  封装点击放大的滚动视图
//
//  Created by user on 16/5/16.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGTapImage.h"
#import "XGScrollView.h"


@interface XGBroserView : UIView<XGScrollDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView * backView; //背景图片
@property (nonatomic, strong) UIScrollView * scrollView; // 滚动视图
@property (nonatomic, assign) BOOL isBroser;//是否 为轮播图
@property (nonatomic, strong) UIViewController * controller; // 在控制器上显示
@property (nonatomic, strong) UILabel * numLable; //显示lable
@property (nonatomic, assign) CGPoint viewContentOffide; //设置 偏移位置
@property (nonatomic, strong) NSArray * DataArr; //存储数据
@property (nonatomic, assign) BOOL isNativePic;//是否是本地图片
@property (nonatomic, strong) UINavigationController * navController;//设置导航栏

@end
