//
//  DPClassNameCell.h
//  DPFourthRegisterControllertest
//
//  Created by 种子 on 11/10/15.
//  Copyright © 2015 种子. All rights reserved.
//

#import <UIKit/UIKit.h>
//3.声明代理
@protocol DPClassNameDelegate;

static NSString *DPClassNameCellIndentify = @"dpClassNameCellIndentify";
@interface DPClassNameCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ui_classNameText;
//4.创建代理对象delegate
@property (nonatomic, unsafe_unretained) id<DPClassNameDelegate> delegate;

@end
//1.创建DPClassNameDelegate代理
@protocol DPClassNameDelegate <NSObject>

//2.创建代理方法，用于传值
- (void)delegateClassNameWithNSString:(NSString *)nameString;

@end