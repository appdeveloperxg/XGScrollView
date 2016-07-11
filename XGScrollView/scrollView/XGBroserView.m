//
//  XGBroserView.m
//  封装点击放大的滚动视图
//
//  Created by user on 16/5/16.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "XGBroserView.h"
#import "UIImageView+WebCache.h"
@implementation XGBroserView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _backView = [[UIView alloc]initWithFrame:frame];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 1.0;
        [self addSubview:_backView];
    }
    return self;
    
}
-(void)setNavController:(UINavigationController *)navController
{
    _navController = navController;
}
-(void)setDataArr:(NSArray *)DataArr
{
    _DataArr = DataArr;
    CGFloat scYY = self.frame.size.height*0.333;
    
    if (_DataArr.count!=0)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height)];
        _scrollView.tag=222;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.delegate =self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize =CGSizeMake(self.frame.size.width*_DataArr.count, scYY);
        
        for (int i = 0; i<_DataArr.count; i++)
        {
            XGTapImage *image = [[XGTapImage alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, scYY)];
            if (_isNativePic) {
                   image.image = [UIImage imageNamed:_DataArr[i]];
            }else
            {
                NSURL *url = [NSURL URLWithString:_DataArr[i]];
                [image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"暂无@2x"]];

            }
            image.userInteractionEnabled= YES;
            image.multipleTouchEnabled = YES;
            CGRect convertRect = [[image superview] convertRect:image.frame toView:self];
            
            
            XGScrollView *tmpImgScrollView = [[XGScrollView alloc] initWithFrame:(CGRect){i*_scrollView.bounds.size.width,0,_scrollView.bounds.size}];
            tmpImgScrollView.XG_delegate = self;
            [tmpImgScrollView setContentWithFrame:convertRect];
            [tmpImgScrollView setImage:image.image];
            [_scrollView addSubview:tmpImgScrollView];
            [tmpImgScrollView setAnimationRect];
        }
        
        [self addSubview:_scrollView];
        _numLable = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-60, self.frame.size.height-30, 50, 20)];
        _numLable.textAlignment = NSTextAlignmentLeft;
        _numLable.backgroundColor = [UIColor clearColor];
        _numLable.textColor = [UIColor whiteColor];
        
        [self addSubview:_numLable];
    }
    
    [_controller.view addSubview:self];
    [_controller.view bringSubviewToFront:self];
    
}
-(void)setIsNativePic:(BOOL)isNativePic
{
    _isNativePic = isNativePic;
}
-(void)setIsBroser:(BOOL)isBroser
{
    _isBroser = isBroser;
}
-(void)setController:(UIViewController *)controller
{
    _controller = controller;
    [_controller.view addSubview:self];
}
-(void)setViewContentOffide:(CGPoint)viewContentOffide
{
    _scrollView.contentOffset = viewContentOffide;
    
    int page = viewContentOffide.x/_scrollView.frame.size.width;
    
    if (_isBroser) {
        _numLable.text = [NSString stringWithFormat:@"[%d/%lu]",page,_DataArr.count-2 ];
    }else
    {
        _numLable.text = [NSString stringWithFormat:@"[%d/%lu]",page+1,(unsigned long)_DataArr.count];
    }
}

-(void)tapImageViewWithObject:(id)sender
{
    [self removeFromSuperview];
    _navController.navigationBarHidden = NO;
}
#pragma mark--ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_isBroser) {
        
        CGPoint currentPoint = scrollView.contentOffset;
        
        if (currentPoint.x==0) {
            
            scrollView.contentOffset = CGPointMake(self.frame.size.width*(_DataArr.count-2), 0);
            
        }else if (currentPoint.x==self.frame.size.width*(_DataArr.count-1))
        {
            scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        }
        
    }
    int page = scrollView.contentOffset.x/_scrollView.frame.size.width;
    
    if (_isBroser) {
        _numLable.text = [NSString stringWithFormat:@"[%d/%lu]",page,_DataArr.count-2 ];
    }else
    {
        _numLable.text = [NSString stringWithFormat:@"[%d/%lu]",page+1,(unsigned long)_DataArr.count];
    }

    
}
@end
