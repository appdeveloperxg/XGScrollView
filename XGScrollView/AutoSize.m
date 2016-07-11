//
//  AutoSize.m
//  Dome
//
//  Created by wangjiajia on 16/1/4.
//  Copyright © 2016年 wangjiajia. All rights reserved.
//
#define deepBgColor [UIColor colorWithRed:56/255.0 green:62/255.0 blue:72/255.0 alpha:1]

#import "AutoSize.h"

@implementation AutoSize

+(CGRect)autoSizeWithFrame:(CGRect)frame
{
    float autoSizeScaleX;
    float autoSizeScaleY;
    if ([UIScreen mainScreen].bounds.size.height<=480) {
        autoSizeScaleX=1.05;
        autoSizeScaleY=1.05;
    }
    else
    {
        autoSizeScaleX=[UIScreen mainScreen].bounds.size.width/320;
        autoSizeScaleY=[UIScreen mainScreen].bounds.size.height/568;
    
    }
    CGRect rect;
    
    rect.origin.x=frame.origin.x*autoSizeScaleX;
    rect.origin.y=frame.origin.y*autoSizeScaleY;
    rect.size.width=frame.size.width*autoSizeScaleX;
    rect.size.height=frame.size.height*autoSizeScaleY;
    
    return rect;
}

+(NSString *)getLocalizableStringWithKey:(NSString *)key
{

    NSString *value=NSLocalizedStringFromTable(key, @"BasicTitle", @"");

    return value;
}
///计算一天以后的时间
+(NSString *)calculateDateWithNum:(NSInteger)num
{
    
    NSDate *date=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:num];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDateString=[dateFormatter stringFromDate:newdate];
    return newDateString;
}
+(NSString *)returnWeekDay:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *theDate=[dateFormatter dateFromString:date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;

    comps = [calendar components:unitFlags fromDate:theDate];
    
    NSInteger week = [comps weekday];
    NSString *weekDayStr;
    switch (week) {
        case 1:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Sunday"];
            break;
        case 2:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Monday"];
            break;
        case 3:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Tuesday"];
            break;
        case 4:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Wednesday"];
            break;
        case 5:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Thursday"];
            break;
        case 6:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Friday"];
            break;
        case 7:
            weekDayStr =[AutoSize getLocalizableStringWithKey:@"Saturday"];
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;



}
@end
