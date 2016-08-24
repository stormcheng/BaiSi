//
//  CHBTopic.m
//  BuDeJie11
//
//  Created by ibokanwisdom on 16/7/25.
//  Copyright © 2016年 IbokanWisdom. All rights reserved.
//

#import "CHBTopic.h"
#import "NSDate+CHBExtension.h"
@implementation CHBTopic
// 获得cell的高度
-(CGFloat)cellHeight{
    if (_cellHeight) return _cellHeight;
    //1.获取文字的高度
    CGFloat textHeight =[self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width- 2 * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    _cellHeight += 55 +textHeight;
    
    if (self.type != CHBTopicTypeWord) { // 中间有内容（图片、声音、视频）
        
        CGFloat middleW = [UIScreen mainScreen].bounds.size.width-20;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= CHBScreenH) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleY = _cellHeight +10;
        CGFloat middleX = 10;
        self.centerFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + 10;
    }
    // 有最热评论
    if (self.top_cmt.count) {
        // 标题
        _cellHeight += 21;
        // 内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width- 2 * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height +10;
    }
    _cellHeight += 35 + 20;
    return _cellHeight;
}

#pragma mark - 设置时间
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
/**
 *  在第一次使用XMGTopic类时调用1次
 */
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

- (NSString *)passtime
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_passtime];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        } else { // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _passtime;
    }
}


@end
