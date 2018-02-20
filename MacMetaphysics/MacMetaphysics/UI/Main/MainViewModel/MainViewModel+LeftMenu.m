//
//  MainViewModel+LeftMenu.m
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/6.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewModel+LeftMenu.h"

@implementation MainViewModel (LeftMenu)

#pragma mark - 左边菜单相关方法
-(NSString*)getSpecificMenuTitleWithType:(LeftSideMenuType)type{
    NSString *result = @"";
    
    switch (type) {
        case LeftSideMenuTypeChaoDai:
            result = @"朝代";
            break;
        case LeftSideMenuTypeShuangZao:
            result = @"双造";
            break;
        case LeftSideMenuTypeDaYun:
            result = @"大运";
            break;
        case LeftSideMenuTypeYongShen:
            result = @"用神-忌神";
            break;
        case LeftSideMenuTypeGeJu:
            result = @"格局-象意";
            break;
        case LeftSideMenuTypeXiangMao:
            result = @"相貌-性格";
            break;
        case LeftSideMenuTypeWenPin:
            result = @"文凭-特长";
            break;
        case LeftSideMenuTypeFuMu:
            result = @"父母";
            break;
        case LeftSideMenuTypeXiongDi:
            result = @"兄弟";
            break;
        case LeftSideMenuTypeZiNv:
            result = @"子女";
            break;
        case LeftSideMenuTypeHunYin:
            result = @"婚姻";
            break;
        case LeftSideMenuTypeGuanGui:
            result = @"官贵";
            break;
        case LeftSideMenuTypeCaiFu:
            result = @"财富";
            break;
        case LeftSideMenuTypeGuanSi:
            result = @"官司-牢狱";
            break;
        case LeftSideMenuTypeJiBing:
            result = @"疾病-灾祸";
            break;
        case LeftSideMenuTypeYanSe:
            result = @"色●";
            break;
        case LeftSideMenuTypeShenSha:
            result = @"神煞表";
            break;
        case LeftSideMenuTypeCountQiYunUseHour:
            result = @"起运-小时";
            break;
        case LeftSideMenuTypeVersion:
            result = @"04_29";
            break;
            
        default:
            break;
    }
    
    return result;
}

-(LeftSideMenuType)getSpecificMenuTypeWithIndexPath:(NSIndexPath*)indexPath{
    LeftSideMenuType type = LeftSideMenuTypeChaoDai;
    
    if(self.leftMenuArr.count>indexPath.section){
        NSArray *temp = self.leftMenuArr[indexPath.section];
        if(temp.count>indexPath.item){
            type = (LeftSideMenuType)[temp[indexPath.item] integerValue];
        }
    }
    return type;
}

#pragma mark - 选择菜单的某一项
-(void)selectMunuWithIndexPath:(NSIndexPath*)indexPath{
    LeftSideMenuType type = [self getSpecificMenuTypeWithIndexPath:indexPath];
    switch (type) {
        case LeftSideMenuTypeDaYun:          /**<大运*/
        case LeftSideMenuTypeYongShen:       /**<用神-忌神*/
        case LeftSideMenuTypeGeJu:           /**<格局-象意*/
            
        case LeftSideMenuTypeXiangMao:       /**<相貌-性格*/
        case LeftSideMenuTypeWenPin:         /**<文凭-特长*/
        case LeftSideMenuTypeFuMu:           /**<父母*/
        case LeftSideMenuTypeXiongDi:        /**<兄弟*/
        case LeftSideMenuTypeZiNv:           /**<子女*/
            
        case LeftSideMenuTypeHunYin:         /**<婚姻*/
        case LeftSideMenuTypeGuanGui:        /**<官贵*/
        case LeftSideMenuTypeCaiFu:          /**<财富*/
        case LeftSideMenuTypeGuanSi:         /**<官司-牢狱*/
        case LeftSideMenuTypeJiBing:         /**<疾病-灾祸*/
        {
            if(self.currentBottomSectionMenuType != type &&
               self.currentBottomSectionMenuType == LeftSideMenuTypeEmpty){
                
                self.currentBottomSectionMenuType = type;
                //将15运的选择tag置为notfound，并隐藏
                self.fifteenYunData.fifteenYunSelectedNumber = -1;
            }
            else{
                [self.leftMenuBottomTextData resetData];
                self.currentBottomSectionMenuType = LeftSideMenuTypeEmpty;
            }
            
            [(RACSubject*)self.leftMenuClickTextViewOperationSig sendNext:nil];
            [(RACSubject*)self.currentBottomTextViewOperationSig sendNext:nil];
        }
            break;
        case LeftSideMenuTypeShuangZao:
        case LeftSideMenuTypeShenSha:
        case LeftSideMenuTypeYanSe:
        {
            if([self.currentSelectTopSectionMenuTypeArr containsObject:@(type)]){
                [self.currentSelectTopSectionMenuTypeArr removeObject:@(type)];
            }
            else{
                [self.currentSelectTopSectionMenuTypeArr addObject:@(type)];
            }
            [(RACSubject*)self.leftMenuTopSelectedOperationSig sendNext:nil];
            
            if(type == LeftSideMenuTypeYanSe){
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationKey_changeColor
                                                                    object:nil];
            }
        }
            break;
        case LeftSideMenuTypeCountQiYunUseHour:
        {
            self.useHourCountQiYun = !self.useHourCountQiYun;
        }
            break;
        default:
            break;
    }
    [(RACSubject*)self.reloadLeftTableSig sendNext:nil];
    [(RACSubject*)self.reloadBottomTablesSig sendNext:nil];
}

@end
