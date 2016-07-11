//
//  XGTapImage.h
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XGTapImageDelegate <NSObject>

-(void)tappedWithOject:(id)sender;

@end

@interface XGTapImage : UIImageView

@property(nonatomic,strong) id identifier;

@property (weak) id<XGTapImageDelegate> XG_delegate;

@end
