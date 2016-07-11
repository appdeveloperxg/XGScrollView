//
//  XGImageScrollView.m
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "XGImageScrollView.h"
#import "UIImageView+WebCache.h"
#import "AutoSize.h"
#define  WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation XGImageScrollView

//@property (nonatomic, copy)的setter生成的代码大致如下: - (void) setArrayList: (NSMutableArray*) newArrayList { NSArrayList *copy = [newArrayList copy]; [arrayList release]; arrayList = copy; }因为声明了@property (nonatomic, copy)的属性，默认调用的是copy方法，而NSMutableArray的copy方法返回的是NSArray类型，所以无法调用addObject,只能用mutableCopy,遗憾的是，@property不支持mutableCopy的声明。
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createScrollViewMini];
        
    }
    return self;
}
-(void)setController:(UIViewController *)controller
{
    _controller = controller;
}

-(void)setImageArray:(NSMutableArray *)ImageArray
{
    _ImageArray = [[NSMutableArray alloc]initWithArray:ImageArray];
    NSLog(@"ImageArray==========%@",ImageArray);//
}
-(void)createScrollViewMini
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.delegate = self;
    _scrollView.bouncesZoom = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;

    [self addSubview:_scrollView];
}
-(void)setIsNativePicture:(BOOL)isNativePicture
{
    _isNativePicture = isNativePicture;
}
-(void)setIsBroser:(BOOL)isBroser
{
    _isBroser = isBroser;
}
-(void)setDataArray:(NSArray *)DataArray
{
    if (!_isBroser) {
        if (_ImageArray.count>0) {
            [_ImageArray removeAllObjects];
            [_ImageArray addObjectsFromArray:DataArray];
        }else
        {
            _ImageArray = [[NSMutableArray alloc]initWithArray:DataArray];
        }
   
    }else
    {
        if (_ImageArray.count>0) {
            [_ImageArray removeAllObjects];
            [_ImageArray addObject:[DataArray lastObject]];
            [_ImageArray addObjectsFromArray:DataArray];
            [_ImageArray addObject:[DataArray firstObject]];
        }else
        {
            _ImageArray = [[NSMutableArray alloc]initWithObjects:[DataArray lastObject], nil];
            [_ImageArray addObjectsFromArray:DataArray];
            [_ImageArray addObject:[DataArray firstObject]];
        }
    }
    if (_scrollView.subviews>0) {
        [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }

    float height=[AutoSize autoSizeWithFrame:CGRectMake(0, 0, 375, self.frame.size.height)].size.height;
    [_ImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * str = [NSString stringWithFormat:@"%@",obj];
         XGTapImage * imageView =[[XGTapImage alloc]initWithFrame:CGRectMake(idx*self.frame.size.width, 0, self.frame.size.width, height)];
         imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if (_isNativePicture) {
            imageView.image = [UIImage imageNamed:str];

        }else
        {
            NSURL * url = [NSURL URLWithString:str];
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        }
                imageView.XG_delegate = self;
        [_scrollView addSubview:imageView];
    }];
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*_ImageArray.count, self.frame.size.height);
    if (_isBroser) {
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_isBroser) {
        
        CGPoint currentPoint = scrollView.contentOffset;
        
        if (currentPoint.x==0) {
            
            scrollView.contentOffset = CGPointMake(self.frame.size.width*(_ImageArray.count-2), 0);
            
        }else if (currentPoint.x==self.frame.size.width*(_ImageArray.count-1))
        {
            scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        }
        
    }
    
    if ([self.xg_delegate respondsToSelector:@selector(XG_scrollViewDidEndDecelerating:)]) {
        [self.xg_delegate XG_scrollViewDidEndDecelerating:scrollView];
    }
}
-(void)setNavController:(UINavigationController *)NavController
{
    _NavController = NavController;
}
-(void)tappedWithOject:(id)sender
{
        NSLog(@"点击图片");
    if ([self.xg_delegate respondsToSelector:@selector(didClickXGImageScrollView:)]) {

        [self.xg_delegate didClickXGImageScrollView:_scrollView];
    }
    
    _NavController.navigationBarHidden = YES;
    
    self.broser =[[XGBroserView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.broser.isNativePic = _isNativePicture;
    self.broser.isBroser = _isBroser;
    self.broser.controller = _controller;
    self.broser.DataArr = _ImageArray;
    self.broser.viewContentOffide = _scrollView.contentOffset;
    self.broser.numLable.hidden = YES;
    self.broser.navController = _NavController;
    
//    [_controller.view addSubview:broser];
}


@end
