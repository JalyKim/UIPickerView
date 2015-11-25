


//
//  DPClassRateCell.m
//  DPFourthRegisterControllertest
//
//  Created by 种子 on 11/12/15.
//  Copyright © 2015 种子. All rights reserved.
//

#import "DPClassRateCell.h"

@implementation DPClassRateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

//5.按钮点击事件，执行代理中的方法delegateClassRateWithArray:，并传递参数array
- (IBAction)onClickAction
{
    if ([self.delegate respondsToSelector:@selector(delegateClassRateWithArray:)])
    {
        [self.delegate delegateClassRateWithArray:[NSArray arrayWithObjects:@"1", nil]];
    }
}

@end
