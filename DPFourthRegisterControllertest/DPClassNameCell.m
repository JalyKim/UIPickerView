

//
//  DPClassNameCell.m
//  DPFourthRegisterControllertest
//
//  Created by 种子 on 11/10/15.
//  Copyright © 2015 种子. All rights reserved.
//

#import "DPClassNameCell.h"

@implementation DPClassNameCell

- (void)awakeFromNib {
    
    self.ui_classNameText.delegate = self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑的一瞬间");
//    5.如果响应本代理中这个方法，则执行传值
    if ([self.delegate respondsToSelector:@selector(delegateClassNameWithNSString:)])
    {
        [self.delegate delegateClassNameWithNSString:self.ui_classNameText.text];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
