
//
//  DPFourthRegisterController.m
//  DPFourthRegisterControllertest
//
//  Created by 种子 on 11/10/15.
//  Copyright © 2015 种子. All rights reserved.
//

#import "DPFourthRegisterController.h"
#import "DPClassNameCell.h"
#import "DPClassRateCell.h"
#import "DPClassPriceCell.h"
#import "DPStudentAddressCell.h"
#import "DPOutTeachingCell.h"
BOOL flag1 = NO;
BOOL flag2 = NO;
BOOL constraintFlag = NO;
@interface DPFourthRegisterController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,delegateClassRate,DPClassNameDelegate>
@property (nonatomic, strong) DPStudentAddressCell *dpStudentAddressCell;
@property (nonatomic, strong) DPOutTeachingCell *dpOutTeachingCell;
@property (weak, nonatomic) IBOutlet UIPickerView *ui_classRatePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ui_pickerConstraint;
@property (nonatomic, strong) NSArray *ui_proviceArr;//省份数组
@property (nonatomic, strong) NSArray *ui_cityArr;//城市数据，随着省份的变化而变化
@property (nonatomic, strong) NSMutableDictionary *ui_citySelectDic;//存放“省份-城市”数据源
@end

@implementation DPFourthRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ui_pickerConstraint.constant = -150.0f;
    self.ui_classRatePicker.delegate = self;
    self.ui_classRatePicker.dataSource = self;
    
    self.ui_proviceArr = [self defineArr];
    self.ui_cityArr = [self defineArr];
    self.ui_citySelectDic = [self defineDic];
    
    self.ui_proviceArr = @[@"山西",@"陕西"];
    NSArray *cityArr = @[@[@"太原",@"长治",@"忻州"],@[@"西安",@"渭南",@"周至",@"安康"]];
   
    for (int i = 0; i<self.ui_proviceArr.count; i++)
    {
//        将省份与城市对应起来，并写入字典
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[cityArr objectAtIndex:i],[self.ui_proviceArr objectAtIndex:i], nil];
//        将对应遍历的字典加入到全局的新字典
        [self.ui_citySelectDic addEntriesFromDictionary:dict];
    }
//    拿到选中的component
    NSInteger selectProviceIndex = [self.ui_classRatePicker selectedRowInComponent:0];
    NSLog(@"%ld",selectProviceIndex);
//    拿到选中的省份(走pickerView代理)
    NSString *selectProviceStr = [self.ui_proviceArr objectAtIndex:selectProviceIndex];
//    拿到选中的省份的城市名称
    self.ui_cityArr = [self.ui_citySelectDic objectForKey:selectProviceStr];
    
}

#pragma mark -- 声明数组和字典
-(NSArray *)defineArr
{
    NSArray *arr;
    if (arr == nil)
    {
        arr = [[NSArray alloc]init];
    }
    return arr;
}
-(NSMutableDictionary *)defineDic
{
    NSMutableDictionary *dic;
    if (dic == nil)
    {
        dic = [[NSMutableDictionary alloc]init];
    }
    return dic;
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource

//设置picker的轮子个数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//设置picker每个轮子个item个数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.ui_proviceArr.count;
    }
    else
    {
        return self.ui_cityArr.count;
    }
}
//设置每个轮子每一项显示什么内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.ui_proviceArr[row];
    }
    else
    {
        return self.ui_cityArr[row];
    }
}
//轮子滚动时候，执行此代理
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        NSString *selectProvice = [self.ui_proviceArr objectAtIndex:row];
        self.ui_cityArr = [self.ui_citySelectDic objectForKey:selectProvice];
#warning mark -- 重点！更新第二个轮子的数据
        [self.ui_classRatePicker reloadComponent:1];
//        获得第1个component选中的row
        NSInteger selectCityIndex = [self.ui_classRatePicker selectedRowInComponent:1];
        NSString *selectCity = [self.ui_cityArr objectAtIndex:selectCityIndex];
        NSLog(@"%@-------%@",selectProvice,selectCity);
    }
    else
    {
//        获得第0个component选中的row
        NSInteger selectProviceIndex = [self.ui_classRatePicker selectedRowInComponent:0];
        NSString *selectProvice = [self.ui_proviceArr objectAtIndex:selectProviceIndex];
        NSString *selectCity = [self.ui_cityArr objectAtIndex:row];
        NSLog(@"%@=====%@",selectProvice,selectCity);
    }
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 100;
    }
    else
    {
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 60;
    }
    else
    {
        return 170;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setShowsVerticalScrollIndicator:NO];
//    第零个section
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            BOOL nibsRegistered = NO;
            if (!nibsRegistered)
            {
                UINib *nib = [UINib nibWithNibName:@"DPClassNameCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:DPClassNameCellIndentify];
                nibsRegistered = YES;
            }
            UITableViewCell *cell = nil;
            cell = [self configClassNameWithIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            BOOL nibsRegistered = NO;
            if (!nibsRegistered)
            {
                UINib *nib = [UINib nibWithNibName:@"DPClassRateCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:DPClassRateCellIdentify];
                nibsRegistered = YES;
            }
            UITableViewCell *cell = nil;
            cell = [self configClassRateWithIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 2)
        {
            BOOL nibsRegistered = NO;
            if (!nibsRegistered)
            {
                UINib *nib = [UINib nibWithNibName:@"DPClassPriceCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:DPClassPriceCellIndentify];
                nibsRegistered = YES;
            }
            UITableViewCell *cell = nil;
            cell = [self configClassPriceWithIndexPath:indexPath];
            return cell;
        }
    }
//    第一个section
    else if (indexPath.section == 1)
    {
        BOOL nibsRegistered = NO;
        if (!nibsRegistered)
        {
            UINib *nib = [UINib nibWithNibName:@"DPStudentAddressCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:DPStudentAddressCellIndentify];
            nibsRegistered = YES;
        }
        self.dpStudentAddressCell = [self configStudentAddressWithIndexPath:indexPath];
        return self.dpStudentAddressCell;
    }
    else if (indexPath.section == 2)
    {
        BOOL nibsRegistered = NO;
        if (!nibsRegistered)
        {
            UINib *nib = [UINib nibWithNibName:@"DPOutTeachingCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:DPOutTeachingCellIdentify];
            nibsRegistered = YES;
        }
        self.dpOutTeachingCell = [self configOutTeachingWithIndexPath:indexPath];
        return self.dpOutTeachingCell;
    }
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld----%ld",indexPath.section,indexPath.row);
    if (indexPath.section == 1)
    {
        if (flag1 == NO)
        {
            flag1 = YES;
            self.dpStudentAddressCell.layer.cornerRadius = 8.0f;
            self.dpStudentAddressCell.layer.borderWidth = 2.0f;
            self.dpStudentAddressCell.layer.borderColor = [UIColor blueColor].CGColor;
        }
        else
        {
            flag1 = NO;
            self.dpStudentAddressCell.layer.borderWidth = 0;
        }
    }
    else if (indexPath.section == 2)
    {
        if (flag2 == NO)
        {
            flag2 = YES;
            self.dpOutTeachingCell.layer.cornerRadius = 8.0f;
            self.dpOutTeachingCell.layer.borderWidth = 2.0f;
            self.dpOutTeachingCell.layer.borderColor = [UIColor blueColor].CGColor;
        }
        else
        {
            flag2 = NO;
            self.dpOutTeachingCell.layer.borderWidth = 0;
        }
    }
}

#pragma mark -- 定义各个cell

-(DPClassNameCell *)configClassNameWithIndexPath:(NSIndexPath *)indexPath
{
    DPClassNameCell *cell = [self.ui_mainTableView dequeueReusableCellWithIdentifier:DPClassNameCellIndentify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    return cell;
}
-(DPClassRateCell *)configClassRateWithIndexPath:(NSIndexPath *)indexPath
{
    DPClassRateCell *cell = [self.ui_mainTableView dequeueReusableCellWithIdentifier:DPClassRateCellIdentify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    return cell;
}
-(DPClassPriceCell *)configClassPriceWithIndexPath:(NSIndexPath *)indexPath
{
    DPClassPriceCell *cell = [self.ui_mainTableView dequeueReusableCellWithIdentifier:DPClassPriceCellIndentify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(DPStudentAddressCell *)configStudentAddressWithIndexPath:(NSIndexPath *)indexPath
{
    DPStudentAddressCell *cell = [self.ui_mainTableView dequeueReusableCellWithIdentifier:DPStudentAddressCellIndentify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(DPOutTeachingCell *)configOutTeachingWithIndexPath:(NSIndexPath *)indexPath
{
    DPOutTeachingCell *cell = [self.ui_mainTableView dequeueReusableCellWithIdentifier:DPOutTeachingCellIdentify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark -- delegateClassRate代理
//6.导入"DPClassRateCell.h"头文件，并引入delegateClassRate代理协议，在对应的cell中添加cell.delegate = self，调用代理里面的方法
-(void)delegateClassRateWithArray:(NSArray *)array
{
    if (constraintFlag == NO)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.ui_pickerConstraint.constant = 0;
            [self.ui_classRatePicker layoutIfNeeded];
        }];
        constraintFlag = YES;
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.ui_pickerConstraint.constant = -150.0f;
            [self.ui_classRatePicker layoutIfNeeded];
            
        }];
        constraintFlag = NO;
    }
    
}
#pragma mark -- DPClassNameDelegate
-(void)delegateClassNameWithNSString:(NSString *)nameString
{
//    运用代理，拿到cell中的textfield的值
    NSLog(@"++++++++%@",nameString);
}
@end
