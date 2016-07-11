//
//  XGTapImage.m
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "XGTapImage.h"

@implementation XGTapImage

-(void)dealloc
{
    self.XG_delegate = nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;

        
    }
    return self;
}
-(void)tapped:(id)sender
{
    if ([self.XG_delegate respondsToSelector:@selector(tappedWithOject:)]) {
        [self.XG_delegate tappedWithOject:self];
    }
}
@end
