//
//  AutoSize.h
//  Dome
//
//  Created by wangjiajia on 16/1/4.
//  Copyright © 2016年 wangjiajia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AutoSize : NSObject

+(CGRect)autoSizeWithFrame:(CGRect)frame;
///   获取国际化语言文字
+(NSString *)getLocalizableStringWithKey:(NSString *)key;
///计算n天以后的时间
+(NSString *)calculateDateWithNum:(NSInteger)num;
+(NSString *)returnWeekDay:(NSString *)date;
@end
