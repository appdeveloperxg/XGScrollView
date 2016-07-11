//
//  XGImageScrollView.h
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGTapImage.h"
#import "XGScrollView.h"
#import "XGBroserView.h"
@protocol XGScrollViewDelegate <NSObject>

@optional
-(void)didClickXGImageScrollView:(id)object;
-(void)XG_scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface XGImageScrollView : UIView<UIScrollViewDelegate,XGTapImageDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, copy) NSMutableArray * ImageArray;
@property (nonatomic, assign) id<XGScrollViewDelegate> xg_delegate;
@property (nonatomic, strong) XGBroserView * broser;
//以下为必须设置选项
//是否轮播效果
@property (nonatomic, assign) BOOL isBroser;
//是否 是本地图片
@property (nonatomic, assign) BOOL isNativePicture;
// 添加在什么控制器之上
@property (nonatomic, strong) UIViewController * controller;
//隐藏导航栏
@property (nonatomic, strong) UINavigationController * NavController;

-(instancetype)initWithFrame:(CGRect)frame;
//创建滚动视图
-(void)setDataArray:(NSArray *)DataArray;

@end
