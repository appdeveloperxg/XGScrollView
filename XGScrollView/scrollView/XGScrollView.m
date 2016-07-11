//
//  XGScrollView.m
//  封装点击放大的滚动视图
//
//  Created by user on 16/3/29.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

#import "XGScrollView.h"

@interface XGScrollView()
{
    UIImageView * imageView ;
    
    //记录自己的位置
    CGRect scaleOriginRect;
    
    //图片的大小
    CGSize imgSize;
    
    //缩放前的大小
    CGRect initRect;
    
}
@end


@implementation XGScrollView
-(void)dealloc
{
    _XG_delegate = nil;
}
/*!
 *   @brief UIScrollView不仅能滚动显示大量内容，还能对其内容进行缩放处理。也就是说，要完成缩放功能的话，只需要将需要缩放的内容添加到UIScrollView中
 
 2.缩放原理
 
 当用户在UIScrollView身上使用捏合手势时，UIScrollView会给代理发送一条消息，询问代理究竟要缩放自己内部的哪一个子控件（哪一块内容）当用户在UIScrollView身上使用捏合手势时，UIScrollView会调用代理的viewForZoomingInScrollView:方法，这个方法返回的控件就是需要进行缩放的控件。
 *
 *
 *
 */
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.bounces = NO;
        self.bouncesZoom = YES;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.minimumZoomScale = 1.0;
        self.scale = 1.0;
        
        imageView = [[UIImageView alloc]init];
        imageView.clipsToBounds = YES;
        imageView.center = self.center;
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoClick:)];
        singleTap.delegate = self;
        
        // 双击放大图片
//        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTaped:)];
//        doubleTap.numberOfTapsRequired = 2;
//        doubleTap.delegate = self;
//        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [self addGestureRecognizer:singleTap];
//        [self addGestureRecognizer:doubleTap];
        
//        UIRotationGestureRecognizer * rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(actionRotation:)];
//        rotation.delegate = self;
//        [self addGestureRecognizer:rotation];
        
        [self addSubview:imageView];
    }
    
    return self;
}
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if(gestureRecognizer.view==otherGestureRecognizer.view){
//        return YES;
//    }else{
//        return NO;
//    }
//}
-(void)actionRotation:(UIRotationGestureRecognizer*)rotation
{
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
     rotation.rotation = 1.0;
}

-(void)photoClick:(UITapGestureRecognizer*)tap
{
    if ([self.XG_delegate respondsToSelector:@selector(tapImageViewWithObject:)]) {
        
        [self.XG_delegate tapImageViewWithObject:self];
    }

}
//-(void)imageViewDoubleTaped:(UITapGestureRecognizer*)tap
//{
//    static BOOL iszoom = YES;
//    
//    if (self.scale<2.0) {
//        
//        [self zoomWithScale:2.0];
//        self.scale = 2.0;
//    }else
//    {
//
//        [self zoomWithScale:1.0];
//        self.scale = 1.0;
//    }
//    iszoom = !iszoom;
//  
//}
- (void)zoomWithScale:(CGFloat)scale
{
    
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    if (scale > 1.0) {
        CGFloat contentW = imageView.frame.size.width;
        CGFloat contentH = MAX(imageView.frame.size.height, self.frame.size.height);
        
        imageView.center = CGPointMake(contentW * 0.5, contentH * 0.5);
        self.contentSize = CGSizeMake(contentW, contentH);
        
        
        CGPoint offset = self.contentOffset;
        offset.x = (contentW - self.frame.size.width) * 0.5;
        self.contentOffset = offset;
        
    } else {
        self.contentSize = self.frame.size;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
}


-(void)setContentWithFrame:(CGRect)frame
{
    imageView.frame = frame;//最初imageView的大小
    initRect = frame;//最初的大小
}
-(void)setAnimationRect
{
    imageView.frame = scaleOriginRect;//记录自己原先的位置
}

-(void)rechangeInitRdct
{
    self.zoomScale = 1.0;
    imageView.frame = initRect; //还原
}
-(void)setImage:(UIImage *)image
{
    if (image) {
        
        imageView.image = image;
        imgSize = image.size;
        
        
        //判断首先缩放的值
        float scaleX = self.frame.size.width/imgSize.width;
        float scaleY = self.frame.size.height/imgSize.height;
        
        //倍数小的 先到边缘
        if (scaleX>scaleY) {
            
            float imageViewWidth = imgSize.width * scaleY;
            self.maximumZoomScale = self.frame.size.width/imageViewWidth;
            
            scaleOriginRect = (CGRect){self.frame.size.width/2-imageViewWidth/2,0,imageViewWidth,self.frame.size.height};

        }else
        {
            //x先到边缘
            
            float imageViewHeight = imgSize.height * scaleX;
            self.maximumZoomScale = self.frame.size.height/imageViewHeight;
            
            scaleOriginRect = (CGRect){0,self.frame.size.height/2-imageViewHeight/2,self.frame.size.width,imageViewHeight};
        }
        
        
    }
}
#pragma mark -- UIscrollViewDelegate
/*!
 *   @brief UiscrollView 的放大缩小功能
 *
 */
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundSize = scrollView.bounds.size;//记录scrollView的大小
    CGRect imgFrame = imageView.frame;//记录imageView的位置
    CGSize contentSize = scrollView.contentSize;//记录scrollView 内容大小
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    self.scale = contentSize.width/boundSize.width;
    
    if(imgFrame.size.width <= boundSize.width)
    {
        centerPoint.x = boundSize.width/2;
    }
    
    
    if (imgFrame.size.height <= boundSize.height) {
        
        centerPoint.y = boundSize.height/2;
    }
    
    imageView.center = centerPoint;
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   }
@end
