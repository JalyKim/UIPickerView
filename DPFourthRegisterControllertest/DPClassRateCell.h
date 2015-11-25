//
//  DPClassRateCell.h
//  DPFourthRegisterControllertest
//
//  Created by 种子 on 11/12/15.
//  Copyright © 2015 种子. All rights reserved.
//

#import <UIKit/UIKit.h>
//3.声明代理名
@protocol delegateClassRate;

static NSString *DPClassRateCellIdentify = @"DPClassRateCellIdentify";
@interface DPClassRateCell : UITableViewCell

//4.创建代理对象delegate
@property (nonatomic, unsafe_unretained) id<delegateClassRate> delegate;
@end

//1.创建delegateClassRate代理
@protocol delegateClassRate <NSObject>
//2.创建代理方法
- (void) delegateClassRateWithArray:(NSArray *) array;

@end