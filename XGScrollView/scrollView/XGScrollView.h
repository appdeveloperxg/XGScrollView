//
//  XGScrollView.h
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XGScrollDelegate <NSObject>

-(void)tapImageViewWithObject:(id)sender;

@end

@interface XGScrollView : UIScrollView <UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,assign) CGFloat scale;
@property(weak) id <XGScrollDelegate> XG_delegate;

- (void) setContentWithFrame:(CGRect) frame;
- (void) setImage:(UIImage*) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;

@end
