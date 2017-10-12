//
//  ShenShaData.m
//  Metaphysics
//
//  Created by Hydra on 2017/3/27.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "ShenShaData.h"
#import "MainViewModel.h"
#import "NSString+Addition.h"
#import "UIConstantParameter.h"
@implementation ShenShaData

-(void)initialize{
    self.yearShenShaArr = @[].mutableCopy;
    self.monthShenShaArr = @[].mutableCopy;
    self.dayShenShaArr = @[].mutableCopy;
    self.hourShenShaArr = @[].mutableCopy;
    self.ganZhiYear = @"";
    self.ganZhiMonth = @"";
    self.ganZhiDay = @"";
    self.ganZhiHour = @"";
    
    self.totalShenShaArr = @[self.yearShenShaArr,
                             self.monthShenShaArr,
                             self.dayShenShaArr,
                             self.hourShenShaArr].mutableCopy;
    
    self.topHourShenShaArr = @[].mutableCopy;
    
    self.bottomMonthShenShaArr = @[].mutableCopy;
    self.bottomDayShenShaArr = @[].mutableCopy;
    self.bottomHourShenShaArr = @[].mutableCopy;
}

-(void)resetData{
    [self resetGanZhiProperty];
    [self removeAll];
    [self isIncluedeTianYi];
    [self isIncludeTianDe];
    [self isIncludeYueDe];
    [self isIncludeTaiJi];
    [self isIncludeHuaGai];
    [self isIncludeWenChang];
    [self isIncludeDeXiu];
    [self isIncludeJiangXing];
    [self isIncludeYiMa];
    [self isIncludeLuShen];
    [self isIncludeYangRen];
    [self isIncludeTaoHua];
    [self isIncludeHongYan];
    [self isIncludeWangShen];
    [self isIncludeJieSha];
    [self isIncludeZaiSha];
    [self isIncludeYuanChen];
    [self isIncludeSiFei];
    [self isIncludeBaZhuan];
    [self isIncludeJiuChou];
    [self isIncludeLiuXia];
    [self isIncludeXueRen];
    [self isIncludeXueZhi];
    [self isIncludeKongWang];
    [self isIncludeXiangPo];
    [self isIncludeXiangChuan];
    [self isIncludeSanQiGuiRen];
    [self isIncludeGuChen];
    [self isIncludeGuaSu];
    [self isIncludeGuLuanSha];
    [self isIncludeJinShenGe];
    [self isIncludeKuiGang];
    [self isIncludeTianLuo];
    [self isIncludeDiWang];
    [self isIncludeYinYangCuoCha];
    [self isIncludeGunLangTaoHua];
    [self isIncludeLuoXingTaoHua];
}

-(void)removeAll{
    [self.yearShenShaArr removeAllObjects];
    [self.monthShenShaArr removeAllObjects];
    [self.dayShenShaArr removeAllObjects];
    [self.hourShenShaArr removeAllObjects];
    
    [self.topHourShenShaArr removeAllObjects];
    
    [self.bottomMonthShenShaArr removeAllObjects];
    [self.bottomDayShenShaArr removeAllObjects];
    [self.bottomDayShenShaArr removeAllObjects];
}

-(void)resetGanZhiProperty{
    CurrentSelectDate *current = [MainViewModel sharedInstance].selectedDate;
    self.ganZhiYear = current.ganZhiYear;
    self.ganZhiMonth = current.ganZhiMonth;
    self.ganZhiDay = current.ganZhiDay;
    self.ganZhiHour = current.ganZhiHour;
    
    self.totalGanZhiArr = @[self.ganZhiYear,
                            self.ganZhiMonth,
                            self.ganZhiDay,
                            self.ganZhiHour].mutableCopy;
    
}

#pragma mark - 添加神煞
//遍历所有干支，符合条件该柱添加上该神煞 branchToBranch 前置条件查支，遍历条件也查支，则要遍历时需要省略前置类型
-(void)traverseWithCheckType:(MiddleSubViewType)checkType
              branchToBranch:(BOOL)branchToBranch
                      result:(NSString *(^)(NSString *stems,NSString *branches))judgeBlock{
    for(NSInteger i = 0;i<self.totalGanZhiArr.count;i++){
        //前置条件若如遍历的subviewtype相同，跳过；比如华盖的丑见丑，年丑不能再比较年
        if(checkType == i && branchToBranch){
            continue;
        }
        
        NSString *ganZhi = self.totalGanZhiArr[i];
        NSString *shenSha = judgeBlock(ganZhi.getStems,ganZhi.getBranches);
        if(shenSha.length>0){
            NSMutableArray *shenShaArray = self.totalShenShaArr[i];
            //如果该队列不包含该神煞，则添加上去
            if(![shenShaArray containsObject:shenSha]){
                [shenShaArray addObject:shenSha];
            }
        }
    }
}

//指定特定某柱，如（八专、九丑）指定日柱查找干支
-(void)specifiedWithMiddleSubViewType:(MiddleSubViewType)subViewType judgeBlock:(NSString *(^)(NSString *stems,NSString *branches))judgeBlock{
    
    NSString *ganZhi = self.totalGanZhiArr[subViewType];
    NSString *shenSha = judgeBlock(ganZhi.getStems,ganZhi.getBranches);
    if(shenSha.length>0){
        NSMutableArray *shenShaArray = self.totalShenShaArr[subViewType];
        //如果该队列不包含该神煞，则添加上去
        if(![shenShaArray containsObject:shenSha]){
            [shenShaArray addObject:shenSha];
        }
    }
}

//指定特定某柱，如（孤辰）并指定特定添加神煞的队列 指定日柱查找干支
-(void)specifiedWithMiddleSubViewType:(MiddleSubViewType)subViewType
                           shenShaArr:(NSMutableArray*)shenShaArr
                           judgeBlock:(NSString *(^)(NSString *stems,NSString *branches))judgeBlock{
    
    NSString *ganZhi = self.totalGanZhiArr[subViewType];
    NSString *shenSha = judgeBlock(ganZhi.getStems,ganZhi.getBranches);
    if(shenSha.length>0){
        //如果该队列不包含该神煞，则添加上去
        if(![shenShaArr containsObject:shenSha]){
            [shenShaArr addObject:shenSha];
        }
    }
}
#pragma mark - 包含的神煞
//是否包含天乙
//甲-丑未、乙-申子、丙-酉亥、丁-酉亥、戊-丑未、己-申子、庚-丑未、辛-寅午、壬-卯巳、癸-卯巳；（年日干查）
-(void)isIncluedeTianYi{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",]
                  traverseConformArr:@[@"丑未",
                                       @"申子",
                                       @"酉亥",
                                       @"酉亥",
                                       @"丑未",
                                       @"申子",
                                       @"丑未",
                                       @"寅午",
                                       @"卯巳",
                                       @"卯巳",]
                                name:@"天乙"];
}

//天德
//寅月丁、卯月申、辰月壬、巳月辛、午月亥、未月甲、申月癸、酉月寅、戌月丙、亥月乙、子月巳、丑月庚
-(void)isIncludeTianDe{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeStems
                        checkTypeArr:@[@(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",
                                       @"子",
                                       @"丑",]
                  traverseConformArr:@[@"丁",
                                       @"申",
                                       @"壬",
                                       @"辛",
                                       @"亥",
                                       @"甲",
                                       @"癸",
                                       @"寅",
                                       @"丙",
                                       @"乙",
                                       @"巳",
                                       @"庚",]
                                name:@"天德"];
}

//月德
//寅月丙、卯月甲、辰月壬、巳月庚、午月丙、未月甲、申月壬、酉月庚、戌月丙、亥月甲、子月壬、丑月庚
-(void)isIncludeYueDe{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeStems
                        checkTypeArr:@[@(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",
                                       @"子",
                                       @"丑",]
                  traverseConformArr:@[@"丙",
                                       @"甲",
                                       @"壬",
                                       @"庚",
                                       @"丙",
                                       @"甲",
                                       @"壬",
                                       @"庚",
                                       @"丙",
                                       @"甲",
                                       @"壬",
                                       @"庚",]
                                name:@"月德"];
}

//太极
//甲日子、乙日午、丙日卯、丁日酉、戊己日（辰戊丑未）、庚日亥、辛日寅、壬日申、癸日巳。（年日干查）
-(void)isIncludeTaiJi{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",]
                  traverseConformArr:@[@"子",
                                       @"午",
                                       @"卯",
                                       @"酉",
                                       @"辰戊丑未",
                                       @"亥",
                                       @"寅",
                                       @"申",
                                       @"巳",]
                                name:@"太极"];
}

//华盖
//子见辰、丑见丑、寅见戌、卯见未、辰见辰、巳见丑、午见戌、未见未、申见辰、酉见丑、戌见戌、亥见未。（年日支查）
-(void)isIncludeHuaGai{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"子",
                                       @"丑",
                                       @"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",]
                  traverseConformArr:@[@"辰",
                                       @"丑",
                                       @"戌",
                                       @"未",
                                       @"辰",
                                       @"丑",
                                       @"戌",
                                       @"未",
                                       @"辰",
                                       @"丑",
                                       @"戌",
                                       @"未",]
                                name:@"华盖"];
}

//文昌
//甲见巳、乙见午、丙见申、丁见酉、戊见申、己见酉、庚见亥、辛见子、壬见寅、癸见卯。（年日干查）
-(void)isIncludeWenChang{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",
                                       ]
                  traverseConformArr:@[@"巳",
                                       @"午",
                                       @"申",
                                       @"酉",
                                       @"申",
                                       @"酉",
                                       @"亥",
                                       @"子",
                                       @"寅",
                                       @"卯",
                                       ]
                                name:@"文昌"];
}

//德秀
//寅午戌月：丙丁为德、戊癸为秀；巳酉丑月：庚辛为德、乙庚为秀；申子辰月：壬癸戊己为德、丙辛甲己为秀；亥卯未月：甲乙为德、丁壬为秀。（月支查）
-(void)isIncludeDeXiu{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeStems
                        checkTypeArr:@[@(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"巳酉丑",
                                       @"申子辰",
                                       @"亥卯未",
                                       ]
                  traverseConformArr:@[@"丙丁戊癸",
                                       @"庚辛乙庚",
                                       @"壬癸戊己丙辛甲己",
                                       @"甲乙丁壬",
                                       ]
                                name:@"德秀"];
}

//将星
//寅午戌见午、巳酉丑见酉、申子辰见子、亥卯未见卯。（年日支查）
-(void)isIncludeJiangXing{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"巳酉丑",
                                       @"申子辰",
                                       @"亥卯未",
                                       ]
                  traverseConformArr:@[@"午",
                                       @"酉",
                                       @"子",
                                       @"卯",
                                       ]
                                name:@"将星"];
}

//驿马
//寅午戌马在申、巳酉丑马在亥、申子辰马在寅、亥卯未马在巳。（年日支查）
-(void)isIncludeYiMa{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"巳酉丑",
                                       @"申子辰",
                                       @"亥卯未",
                                       ]
                  traverseConformArr:@[@"申",
                                       @"亥",
                                       @"寅",
                                       @"巳",
                                       ]
                                name:@"驿马"];
}

//禄神
//甲禄寅、乙禄卯、丙禄巳、丁禄午、戊禄巳、己禄午、庚禄申、辛禄酉、壬禄亥、癸禄子。（日干查）
-(void)isIncludeLuShen{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",
                                       ]
                  traverseConformArr:@[@"寅",
                                       @"卯",
                                       @"巳",
                                       @"午",
                                       @"巳",
                                       @"午",
                                       @"申",
                                       @"酉",
                                       @"亥",
                                       @"子",
                                       ]
                                name:@"禄神"];
}

//羊刃
//甲日卯、乙日寅、丙日午、丁日巳、戊日午未、己日巳辰、庚日酉、辛日申、壬日子、癸日亥。（日干查）
-(void)isIncludeYangRen{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",
                                       ]
                  traverseConformArr:@[@"卯",
                                       @"寅",
                                       @"午",
                                       @"巳",
                                       @"午未",
                                       @"巳辰",
                                       @"酉",
                                       @"申",
                                       @"子",
                                       @"亥",
                                       ]
                                name:@"羊刃"];
}

//桃花
//寅午戌见卯，申子辰见酉，亥卯未见子，巳酉丑见午。（年日支查）
-(void)isIncludeTaoHua{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"申子辰",
                                       @"亥卯未",
                                       @"巳酉丑",
                                       ]
                  traverseConformArr:@[@"卯",
                                       @"酉",
                                       @"子",
                                       @"午",
                                       ]
                                name:@"桃花"];
}

//红艳
//甲日午、乙日午、丙日寅、丁日未、戊日辰、己日辰、庚日戌、辛日酉、壬日子、癸日申。（年日干查）
-(void)isIncludeHongYan{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",
                                       ]
                  traverseConformArr:@[@"午",
                                       @"午",
                                       @"寅",
                                       @"未",
                                       @"辰",
                                       @"辰",
                                       @"戌",
                                       @"酉",
                                       @"子",
                                       @"申",
                                       ]
                                name:@"红艳"];
}

//亡神
//寅午戌见巳，亥卯未见寅，巳酉丑见申，申子辰见亥；（年日支查）
-(void)isIncludeWangShen{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"亥卯未",
                                       @"巳酉丑",
                                       @"申子辰",
                                       ]
                  traverseConformArr:@[@"巳",
                                       @"寅",
                                       @"申",
                                       @"亥",
                                       ]
                                name:@"亡神"];
}

//劫煞
//寅午戌见亥、申子辰见巳、亥卯未见申、巳酉丑见寅。（年日支查）
-(void)isIncludeJieSha{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"寅午戌",
                                       @"申子辰",
                                       @"亥卯未",
                                       @"巳酉丑",
                                       ]
                  traverseConformArr:@[@"亥",
                                       @"巳",
                                       @"申",
                                       @"寅",
                                       ]
                                name:@"劫煞"];
}

//灾煞
//申子辰见午，亥卯未见酉，寅午戌见子，巳酉丑见卯。（年支查）
-(void)isIncludeZaiSha{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       ]
                checkPrecnoditionArr:@[@"申子辰",
                                       @"亥卯未",
                                       @"寅午戌",
                                       @"巳酉丑",
                                       ]
                  traverseConformArr:@[@"午",
                                       @"酉",
                                       @"子",
                                       @"卯",
                                       ]
                                name:@"灾煞"];
}

//元辰
//(阳男阴女查）子年未、丑年申、寅年酉、卯年戌、辰年亥、巳年子、午年丑、未年寅、申年卯、酉年辰、戌年巳、亥年午。
//（阴男阳女查）子年巳、丑年午、寅年未、卯年申、辰年酉、巳年戌、午年亥、未年子、申年丑、酉年寅、戌年卯、亥年辰。
-(void)isIncludeYuanChen{
    MiddleViewData *middleDada = [MainViewModel sharedInstance].middleData;
    NSArray *traverseConformArr = nil;
    //阳男或者阴女
    if(([[self.ganZhiYear getStems] isStemsYang] && middleDada.universeType == UniverseTypeQian) ||
       (![[self.ganZhiYear getStems] isStemsYang] && middleDada.universeType == UniverseTypeKun)){
        traverseConformArr = @[
                               @"未",
                               @"申",
                               @"酉",
                               @"戌",
                               @"亥",
                               @"子",
                               @"丑",
                               @"寅",
                               @"卯",
                               @"辰",
                               @"巳",
                               @"午",
                               ];
    }
    //阴男阳女
    else{
        traverseConformArr = @[
                               @"巳",
                               @"午",
                               @"未",
                               @"申",
                               @"酉",
                               @"戌",
                               @"亥",
                               @"子",
                               @"丑",
                               @"寅",
                               @"卯",
                               @"辰",
                               ];
    }
    
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeYear),
                                       ]
                checkPrecnoditionArr:@[@"子",
                                       @"丑",
                                       @"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",]
                  traverseConformArr:traverseConformArr
                                name:@"元辰"];
}


//四废
//寅卯辰月，遇庚申、辛酉；    巳午未月，遇壬子、癸亥；
//申酉戌月，遇甲寅、乙卯；    亥子丑月，遇丙午、丁巳；（月支查）
-(void)isIncludeSiFei{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        checkTypeArr:@[@(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"寅卯辰",
                                       @"巳午未",
                                       @"申酉戌",
                                       @"亥子丑",
                                       ]
                  traverseConformArr:@[@"庚申、辛酉",
                                       @"壬子、癸亥",
                                       @"甲寅、乙卯",
                                       @"丙午、丁巳",
                                       ]
                                name:@"四废"];
}

//甲寅、乙卯、丁未、戊戌、己未、庚申、辛酉、癸丑。（八专日柱查）
-(void)isIncludeBaZhuan{
    NSArray *traverseConformArr = @[
                                    @"甲寅",
                                    @"乙卯",
                                    @"丁未",
                                    @"戊戌",
                                    @"己未",
                                    @"庚申",
                                    @"辛酉",
                                    @"癸丑",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"八专";
                                      }
                                      return nil;
                                  }];
    }
}

//丁酉、戊子、戊午、己卯、己酉、辛卯、辛酉、壬子、壬午。（九丑日柱查）
-(void)isIncludeJiuChou{
    NSArray *traverseConformArr = @[
                                    @"丁酉",
                                    @"戊子",
                                    @"戊午",
                                    @"己卯",
                                    @"己酉",
                                    @"辛卯",
                                    @"辛酉",
                                    @"壬子",
                                    @"壬午",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"九丑";
                                      }
                                      return nil;
                                  }];
    }
}

//流霞
//甲日酉、乙日戌、丙日未、丁日申、戊日巳、己日午、庚日辰、辛日卯、壬日亥、癸日寅。（流霞日干查）
-(void)isIncludeLiuXia{
    [self shenShaSearchWithCheckType:SBTypeStems
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"甲",
                                       @"乙",
                                       @"丙",
                                       @"丁",
                                       @"戊",
                                       @"己",
                                       @"庚",
                                       @"辛",
                                       @"壬",
                                       @"癸",
                                       ]
                  traverseConformArr:@[@"酉",
                                       @"戌",
                                       @"未",
                                       @"申",
                                       @"巳",
                                       @"午",
                                       @"辰",
                                       @"卯",
                                       @"亥",
                                       @"寅",
                                       ]
                                name:@"流霞"];
}

//血刃
//寅月丑、卯月未、辰月寅、巳月申、午月卯、未月酉、申月辰、酉月戌、戌月巳、亥月亥、子月午、丑月子。（血刃月支查）
-(void)isIncludeXueRen{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",
                                       @"子",
                                       @"丑",
                                       ]
                  traverseConformArr:@[@"丑",
                                       @"未",
                                       @"寅",
                                       @"申",
                                       @"卯",
                                       @"酉",
                                       @"辰",
                                       @"戌",
                                       @"巳",
                                       @"亥",
                                       @"午",
                                       @"子",
                                       ]
                                name:@"血刃"];
}

//血支
//子年戌、丑年酉、寅年申、卯年未、辰年午、巳年巳、午年辰、未年卯、申年寅、酉年丑、戌年子、亥年亥。（血支年支查）
-(void)isIncludeXueZhi{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeMonth),
                                       ]
                checkPrecnoditionArr:@[@"子",
                                       @"丑",
                                       @"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"午",
                                       @"未",
                                       @"申",
                                       @"酉",
                                       @"戌",
                                       @"亥",
                                       ]
                  traverseConformArr:@[@"戌",
                                       @"酉",
                                       @"申",
                                       @"未",
                                       @"午",
                                       @"巳",
                                       @"辰",
                                       @"卯",
                                       @"寅",
                                       @"丑",
                                       @"子",
                                       @"亥",
                                       ]
                                name:@"血支"];
}

//空亡
//甲子旬中戌亥空，甲戌旬中申酉空，甲申旬中午未空，甲午旬中辰巳空，甲辰旬中寅卯空，甲寅旬中子丑空。（年日柱查）
-(void)isIncludeKongWang{
    [self shenShaSearchWithCheckTypeArr:@[
                                          @(MiddleSubViewTypeYear),
                                          @(MiddleSubViewTypeDay),
                                          ]
                   checkPrecnoditionArr:@[
                                          @"甲子",
                                          @"甲戌",
                                          @"甲申",
                                          @"甲午",
                                          @"甲辰",
                                          @"甲寅",
                                          ]
                     traverseConformArr:@[@"戌亥",
                                          @"申酉",
                                          @"午未",
                                          @"辰巳",
                                          @"寅卯",
                                          @"子丑",]
                                   name:@"空亡"];
}

//相破
//(子卯破）（午酉破）（子酉破）（寅亥破）（卯午破）（辰丑破）（巳申破）（未戌破） 日和年月时相比 破卯
-(void)isIncludeXiangPo{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"子",
                                       @"午",
                                       @"子",
                                       @"寅",
                                       @"卯",
                                       @"辰",
                                       @"巳",
                                       @"未",
                                       ]
                  traverseConformArr:@[@"卯",
                                       @"酉",
                                       @"酉",
                                       @"亥",
                                       @"午",
                                       @"丑",
                                       @"申",
                                       @"戌",
                                       ]
                                name:@"破日"];
}

//相穿
//（戌酉穿）（亥申穿）（子未穿）（丑午穿）（寅巳穿）（卯辰穿） 日和年月时相比
-(void)isIncludeXiangChuan{
    [self shenShaSearchWithCheckType:SBTypeBranches
                        traverseType:SBTypeBranches
                        checkTypeArr:@[
                                       @(MiddleSubViewTypeDay),
                                       ]
                checkPrecnoditionArr:@[@"戌",
                                       @"亥",
                                       @"子",
                                       @"丑",
                                       @"寅",
                                       @"卯",
                                       ]
                  traverseConformArr:@[@"酉",
                                       @"申",
                                       @"未",
                                       @"午",
                                       @"巳",
                                       @"辰",
                                       ]
                                name:@"穿日"];
}

//三奇贵人
//甲戊庚、乙丙丁、壬癸辛。（年月日的干、月日时的干顺排）
-(void)isIncludeSanQiGuiRen{
    NSArray *ordersArr = @[@"甲戊庚",
                             @"乙丙丁",
                             @"壬癸辛"];
    //年月日是否符合
    [self conformOrderArr:ordersArr
               startIndex:0
                   length:3];
    [self conformOrderArr:ordersArr
               startIndex:1
                   length:4];
}

//孤辰
//亥子丑年、见寅为 孤辰、见戌为 寡宿；）    （寅卯辰年、见巳为孤辰、见丑为 寡宿；）
//巳午未年、见申为 孤辰、见辰为 寡宿；）    （申酉戌年、见亥为孤辰、见未为 寡宿。）
-(void)isIncludeGuChen{
    [self bottomDayHourShenShaSearchWithCheckType:SBTypeBranches
                              traverseType:SBTypeBranches
                              checkTypeArr:@[
                                             @(MiddleSubViewTypeYear),
                                             ]
                      checkPrecnoditionArr:@[@"亥子丑",
                                             @"寅卯辰",
                                             @"巳午未",
                                             @"申酉戌",
                                             ]
                        traverseConformArr:@[
                                             @"寅",
                                             @"巳",
                                             @"申",
                                             @"亥",
                                             ]
                                      name:@"孤辰"];
}

//寡宿
//亥子丑年、见寅为 孤辰、见戌为 寡宿；）    （寅卯辰年、见巳为孤辰、见丑为 寡宿；）
//巳午未年、见申为 孤辰、见辰为 寡宿；）    （申酉戌年、见亥为孤辰、见未为 寡宿。）
-(void)isIncludeGuaSu{
    [self bottomDayHourShenShaSearchWithCheckType:SBTypeBranches
                              traverseType:SBTypeBranches
                              checkTypeArr:@[
                                             @(MiddleSubViewTypeYear),
                                             ]
                      checkPrecnoditionArr:@[@"亥子丑",
                                             @"寅卯辰",
                                             @"巳午未",
                                             @"申酉戌",
                                             ]
                        traverseConformArr:@[
                                             @"戌",
                                             @"丑",
                                             @"辰",
                                             @"未",
                                             ]
                                      name:@"寡宿"];
}

//孤鸾煞
//乙巳、丙午、丁巳、戊申、戊午、辛亥、壬寅、壬子。（日时柱查）  8个
-(void)isIncludeGuLuanSha{
    NSArray *traverseConformArr = @[
                                    @"乙巳",
                                    @"丙午",
                                    @"丁巳",
                                    @"戊申",
                                    @"戊午",
                                    @"辛亥",
                                    @"壬寅",
                                    @"壬子",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  shenShaArr:self.bottomDayShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"孤鸾煞";
                                      }
                                      return nil;
                                  }];
        
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeHour
                                  shenShaArr:self.bottomHourShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"孤鸾煞";
                                      }
                                      return nil;
                                  }];
    }
}

//金神格
//乙丑、己巳、癸酉。（日时柱）  3日
-(void)isIncludeJinShenGe{
    NSArray *traverseConformArr = @[
                                    @"乙丑",
                                    @"己巳",
                                    @"癸酉",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  shenShaArr:self.bottomDayShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"金神格";
                                      }
                                      return nil;
                                  }];
        
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeHour
                                  shenShaArr:self.bottomHourShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"金神格";
                                      }
                                      return nil;
                                  }];
    }
}

//魁罡
//壬辰、庚戌、庚辰、戊戌。（日柱查）  4日
-(void)isIncludeKuiGang{
    NSArray *traverseConformArr = @[
                                    @"壬辰",
                                    @"庚戌",
                                    @"庚辰",
                                    @"戊戌",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  shenShaArr:self.bottomDayShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"魁罡";
                                      }
                                      return nil;
                                  }];
    }
}

//天罗（男 天罗）
//（戌见亥，亥见戌为天罗）（年日支查）
-(void)isIncludeTianLuo{
    MiddleViewData *middleData = [MainViewModel sharedInstance].middleData;
    if(middleData.universeType == UniverseTypeQian){
        [self bottomDayHourShenShaSearchWithCheckType:SBTypeBranches
                                  traverseType:SBTypeBranches
                                  checkTypeArr:@[
                                                 @(MiddleSubViewTypeYear),
                                                 @(MiddleSubViewTypeDay),
                                                 ]
                          checkPrecnoditionArr:@[@"戌",
                                                 @"亥",
                                                 ]
                            traverseConformArr:@[
                                                 @"亥",
                                                 @"戌",
                                                 ]
                                          name:@"天罗"];
    }
}

//地网（女 地网）
//辰见巳，巳见辰为地网）（年日支查）
-(void)isIncludeDiWang{
    MiddleViewData *middleData = [MainViewModel sharedInstance].middleData;
    if(middleData.universeType == UniverseTypeKun){
        [self bottomDayHourShenShaSearchWithCheckType:SBTypeBranches
                                  traverseType:SBTypeBranches
                                  checkTypeArr:@[
                                                 @(MiddleSubViewTypeYear),
                                                 @(MiddleSubViewTypeDay),
                                                 ]
                          checkPrecnoditionArr:@[@"辰",
                                                 @"巳",
                                                 ]
                            traverseConformArr:@[
                                                 @"巳",
                                                 @"辰",
                                                 ]
                                          name:@"地网"];
    }
    
}

//阴阳错差
//丙子、丙午、丁丑、丁未、戊寅、戊申、辛卯、辛酉、壬辰、壬戌、癸巳、癸亥。（日时柱查）  12日
-(void)isIncludeYinYangCuoCha{
    NSArray *traverseConformArr = @[
                                    @"丙子",
                                    @"丙午",
                                    @"丁丑",
                                    @"丁未",
                                    @"戊寅",
                                    @"戊申",
                                    @"辛卯",
                                    @"辛酉",
                                    @"壬辰",
                                    @"壬戌",
                                    @"癸巳",
                                    @"癸亥",
                                    ];
    
    for(NSString* traverseConform in traverseConformArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                  shenShaArr:self.bottomDayShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"阴阳错差";
                                      }
                                      return nil;
                                  }];
        
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeHour
                                  shenShaArr:self.bottomHourShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConform isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return @"阴阳错差";
                                      }
                                      return nil;
                                  }];
    }
}

//滚浪桃花
//【丙子日、见辛卯月或辛卯时】【辛卯日，见丙子月】滚浪桃花。
-(void)isIncludeGunLangTaoHua{
    [self bottomMonthAndHourShenShaSearchWithCheckTypeArr:@[
                                                     @(MiddleSubViewTypeDay),
                                                     ]
                              checkPrecnoditionArr:@[@"丙子",
                                                     ]
                                traverseConformArr:@[@"辛卯",
                                                     ]
                                              name:@"滚浪桃花"];
    
    [self bottomMonthShenShaSearchWithCheckTypeArr:@[
                                                     @(MiddleSubViewTypeDay),
                                                     ]
                              checkPrecnoditionArr:@[@"辛卯",
                                                     ]
                                traverseConformArr:@[@"丙子",
                                                     ]
                                              name:@"滚浪桃花"];
}

//裸形桃花
//【甲子日、见庚午月或庚午时】【庚午日，见甲子月】裸形桃花。
-(void)isIncludeLuoXingTaoHua{
    [self bottomMonthAndHourShenShaSearchWithCheckTypeArr:@[
                                                     @(MiddleSubViewTypeDay),
                                                     ]
                              checkPrecnoditionArr:@[@"甲子",
                                                     ]
                                traverseConformArr:@[@"庚午",
                                                     ]
                                              name:@"裸形桃花"];
    
    [self bottomMonthShenShaSearchWithCheckTypeArr:@[
                                                     @(MiddleSubViewTypeDay),
                                                     ]
                              checkPrecnoditionArr:@[@"庚午",
                                                     ]
                                traverseConformArr:@[@"甲子",
                                                     ]
                                              name:@"裸形桃花"];
}

#pragma mark - 年月日，日月时顺排序符合某个顺序
-(void)conformOrderArr:(NSArray*)ordersArr
            startIndex:(NSInteger)startIndex
                length:(NSInteger)length{
    //日月时是否符合
    for(NSString *condition in ordersArr){
        NSString *combine = @"";
        for(NSInteger i = startIndex;i<length;i++){
            combine = [combine stringByAppendingString:[self.totalGanZhiArr[i] getStems]];
        }
        if([combine isEqualToString:condition]){
            if(![self.topHourShenShaArr containsObject:@"三奇贵人"]){
                [self.topHourShenShaArr addObject:@"三奇贵人"];
            }
            return;
        }
    }
}

#pragma mark - 统一的算法
/**
 获取年月日时柱右边的神煞

 @param checkType 前置查找类型是天干还是地支,如天乙的年日干查,为SBTypeStems 干
 @param traverseType 遍历的是天干还是地支,如天乙的年日干查,为SBTypeBranches 支
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如天乙年日符合甲乙丙丁午己庚辛壬癸
 @param traverseConformArr 遍历的条件如天乙的丑未，申子，酉亥，丑未等
 @param name 神煞的名字，如天乙
 */
-(void)shenShaSearchWithCheckType:(SBType)checkType
                     traverseType:(SBType)traverseType
                     checkTypeArr:(NSArray*)checkTypeArr
             checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
               traverseConformArr:(NSArray*)traverseConformArr
                             name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //前置条件可能包含多个干支，比如寅午戌马在申，有寅午戌三个，分离它，遍历
        for(NSInteger j = 0;j<preconditions.length;j++){
            //前置条件是否符合
            RACTuple *tuple = nil;
            //前置条件
            tuple = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr
                                                 checkType:checkType];
            RACTupleUnpack(NSNumber* preconform,NSNumber* conformCheckType) = tuple;

            //符合前置条件
            if(preconform.boolValue){
                [self traverseConformStemsOrBranchesWithTraverseConformArr:traverseConformArr
                                                                         i:i
                                                              traverseType:traverseType
                                                                      name:name
                                                            conformCheckType:(MiddleSubViewType)conformCheckType.integerValue
                                                            branchToBranch:(checkType == traverseType)];
            }
        }
    }
    
}

/**
 获取年月日时柱右边的神煞，与上面不同的是遍历的是整体的天干地支，而不是单独某个天干或者地支，所以不需要traverseType
 
 @param checkType 前置查找类型是天干还是地支,如天乙的年日干查,为SBTypeStems 干
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如天乙年日符合甲乙丙丁午己庚辛壬癸
 @param traverseConformArr （四废）寅卯辰月，遇庚申、辛酉；要天干地支两者皆符合
 @param name 神煞的名字，如天乙
 */
-(void)shenShaSearchWithCheckType:(SBType)checkType
                     checkTypeArr:(NSArray*)checkTypeArr
             checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
               traverseConformArr:(NSArray*)traverseConformArr
                             name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //前置条件可能包含多个干支，比如寅午戌马在申，有寅午戌三个，分离它，遍历
        for(NSInteger j = 0;j<preconditions.length;j++){
            //前置条件是否符合
            RACTuple *tuple = nil;
            tuple = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr
                                                 checkType:checkType];
            
            RACTupleUnpack(NSNumber* preconform,NSNumber* conformCheckType) = tuple;
            //符合前置条件
            if(preconform.boolValue){
                [self traverseConformBothWithTraverseConformArr:traverseConformArr
                                                                         i:i
                                                                      name:name
                                               conformCheckType:(MiddleSubViewType)conformCheckType.integerValue
                                                 branchToBranch:NO];
            }
        }
    }
    
}

/**
 获取年月日时柱右边的神煞，与上面不同的是遍历的是整体的天干地支，而不是单独某个天干或者地支，所以不需要traverseType
 
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如空亡 甲子旬中戌亥空，甲戌旬中申酉空，甲申旬中午未空，甲午旬中辰巳空，甲辰旬中寅卯空，甲寅旬中子丑空。（年日柱查）
 @param traverseConformArr （四废）寅卯辰月，遇庚申、辛酉；要天干地支两者皆符合
 @param name 神煞的名字，如天乙
 */
-(void)shenShaSearchWithCheckTypeArr:(NSArray*)checkTypeArr
             checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
               traverseConformArr:(NSArray*)traverseConformArr
                             name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //有可能用、分隔
        NSArray *preconditionArr = [preconditions componentsSeparatedByString:@"、"];
        //前置条件可能包含多个干支用、分开
        for(NSInteger j = 0;j<preconditionArr.count;j++){
            //前置条件是否符合
            RACTuple *tuple = nil;
            //前置条件
            tuple = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr];
            RACTupleUnpack(NSNumber* preconform,NSNumber* conformCheckType) = tuple;
            //符合前置条件
            if(preconform.boolValue){
                [self traverseConformBothWithTraverseConformArr:traverseConformArr
                                                              i:i
                                                           name:name
                                               conformCheckType:(MiddleSubViewType)conformCheckType.integerValue
                                                 branchToBranch:NO];
            }
        }
    }
    
}

/**
 获取底部日，时柱的神煞
 
 @param checkType 前置查找类型是天干还是地支,如天乙的年日干查,为SBTypeStems 干
 @param traverseType 遍历的是天干还是地支,如天乙的年日干查,为SBTypeBranches 支
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如天乙年日符合甲乙丙丁午己庚辛壬癸
 @param traverseConformArr 遍历的条件如天乙的丑未，申子，酉亥，丑未等
 @param name 神煞的名字，如天乙
 */
-(void)bottomDayHourShenShaSearchWithCheckType:(SBType)checkType
                           traverseType:(SBType)traverseType
                           checkTypeArr:(NSArray*)checkTypeArr
                   checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
                     traverseConformArr:(NSArray*)traverseConformArr
                                   name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //前置条件可能包含多个干支，比如寅午戌马在申，有寅午戌三个，分离它，遍历
        for(NSInteger j = 0;j<preconditions.length;j++){
            //前置条件是否符合
            RACTuple *tuple = nil;
            //前置条件
            tuple = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr
                                                 checkType:checkType];
            RACTupleUnpack(NSNumber* preconform,NSNumber* conformCheckType) = tuple;
            //符合前置条件
            if(preconform.boolValue){
                [self bottomDayHourTraverseConformStemsOrBranchesWithTraverseConformArr:traverseConformArr
                                                                               i:i
                                                                    traverseType:traverseType
                                                                            name:name
                                                                       conformCheckType:(MiddleSubViewType)conformCheckType.integerValue];
            }
        }
    }
    
}

/**
 获取底部月时柱的神煞
 
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如空亡 甲子旬中戌亥空，甲戌旬中申酉空，甲申旬中午未空，甲午旬中辰巳空，甲辰旬中寅卯空，甲寅旬中子丑空。（年日柱查）
 @param traverseConformArr （四废）寅卯辰月，遇庚申、辛酉；要天干地支两者皆符合
 @param name 神煞的名字，如天乙
 */
-(void)bottomMonthAndHourShenShaSearchWithCheckTypeArr:(NSArray*)checkTypeArr
                checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
                  traverseConformArr:(NSArray*)traverseConformArr
                                name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //有可能用、分隔
        NSArray *preconditionArr = [preconditions componentsSeparatedByString:@"、"];
        //前置条件可能包含多个干支用、分开
        for(NSInteger j = 0;j<preconditionArr.count;j++){
            //前置条件是否符合
            RACTuple *tuple = nil;
            //前置条件
            tuple = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr];
            RACTupleUnpack(NSNumber* preconform,NSNumber* conformCheckType) = tuple;
            //符合前置条件
            if(preconform.boolValue){
                [self bottomMonthAndHourTraverseConformBothWithTraverseConformArr:traverseConformArr
                                                              i:i
                                                           name:name];
            }
        }
    }
    
}

/**
 获取底部月柱的神煞
 
 @param checkTypeArr 要查找的是年月日时那个柱,如天乙的年日干查,为年和日
 @param checkPrecnoditionArr 查找的干支前置条件,如空亡 甲子旬中戌亥空，甲戌旬中申酉空，甲申旬中午未空，甲午旬中辰巳空，甲辰旬中寅卯空，甲寅旬中子丑空。（年日柱查）
 @param traverseConformArr （四废）寅卯辰月，遇庚申、辛酉；要天干地支两者皆符合
 @param name 神煞的名字，如天乙
 */
-(void)bottomMonthShenShaSearchWithCheckTypeArr:(NSArray*)checkTypeArr
                                  checkPrecnoditionArr:(NSArray*)checkPrecnoditionArr
                                    traverseConformArr:(NSArray*)traverseConformArr
                                                  name:(NSString*)name{
    for(NSInteger i = 0;i<checkPrecnoditionArr.count;i++){
        //多个前置条件中的一个
        NSString *preconditions = checkPrecnoditionArr[i];
        //有可能用、分隔
        NSArray *preconditionArr = [preconditions componentsSeparatedByString:@"、"];
        //前置条件可能包含多个干支用、分开
        for(NSInteger j = 0;j<preconditionArr.count;j++){
            //前置条件是否符合
            BOOL preconform = NO;
            //前置条件
            preconform = [self preconformWithPreconditions:preconditions
                                                         j:j
                                              checkTypeArr:checkTypeArr];
            
            //符合前置条件
            if(preconform){
                [self bottomMonthTraverseConformBothWithTraverseConformArr:traverseConformArr
                                                                                i:i
                                                                             name:name];
            }
        }
    }
    
}

#pragma mark - 前置条件

//前置条件必须符合其中一项才可遍历
-(RACTuple*)preconformWithPreconditions:(NSString*)preconditions
                                 j:(NSInteger)j
                      checkTypeArr:(NSArray*)checkTypeArr
                         checkType:(SBType)checkType
{
    //分离后的每个干或者支
    NSString *precondition = [preconditions substringWithRange:NSMakeRange(j, 1)];
    
    //前置条件的判断，只要其中一种条件符合就可进入遍历阶段
    //柱的类型
    for(NSNumber *checkTypeNumber in checkTypeArr){
        if(self.totalGanZhiArr.count>checkTypeNumber.integerValue){
            //获取柱的类型，比如年天乙的年日干查，取年和日判断条件是否符合
            NSString *ganZhi = self.totalGanZhiArr[checkTypeNumber.integerValue];
            //天干
            if(checkType == SBTypeStems){
                //只要其中一种条件符合，就可遍历
                if([ganZhi.getStems containsString:precondition]){
                    return RACTuplePack(@(YES),checkTypeNumber);
                    
                }
            }
            //地支
            else{
                //只要其中一种条件符合，就可遍历
                if([ganZhi.getBranches containsString:precondition]){
                    return RACTuplePack(@(YES),checkTypeNumber);
                }
            }
        }
    }
    return RACTuplePack(@(NO),nil);
}

//前置条件必须符合其中一项才可遍历
//空亡 甲子旬中戌亥空（年日柱查） 前置条件符合天干地支都相符
-(RACTuple*)preconformWithPreconditions:(NSString*)precondition
                                 j:(NSInteger)j
                      checkTypeArr:(NSArray*)checkTypeArr
{
    
    //前置条件的判断，只要其中一种条件符合就可进入遍历阶段
    //柱的类型
    for(NSNumber *checkTypeNumber in checkTypeArr){
        if(self.totalGanZhiArr.count>checkTypeNumber.integerValue){
            //获取柱的类型，比如年天乙的年日干查，取年和日判断条件是否符合
            NSString *ganZhi = self.totalGanZhiArr[checkTypeNumber.integerValue];
            //干支都相同，比如空亡 年的干支等于甲子
            if([ganZhi isEqualToString:precondition]){
                return RACTuplePack(@(YES),checkTypeNumber);
            }
        }
    }
    return RACTuplePack(@(NO),nil);
}

#pragma mark - 遍历
//遍历只查找天干或者地支其中一个
//conformCheckType 前置条件符合的subviewtype，遍历的时候跳过
-(void)traverseConformStemsOrBranchesWithTraverseConformArr:(NSArray*)traverseConformArr
                                                               i:(NSInteger)i
                                                    traverseType:(SBType)traverseType
                                                            name:(NSString*)name
                                           conformCheckType:(MiddleSubViewType)conformCheckType
                                             branchToBranch:(BOOL)branchToBranch{
    //多个遍历条件中的一个
    NSString *traverseConformStrs = traverseConformArr[i];
    //遍历条件可能包含多个干支，比如天乙的甲-(丑未)
    for(NSInteger k = 0;k<traverseConformStrs.length;k++){
        NSString* traverseConformStr = [traverseConformStrs substringWithRange:NSMakeRange(k, 1)];
        [self traverseWithCheckType:conformCheckType
                     branchToBranch:branchToBranch
                              result:^NSString*(NSString *stems,NSString *branches){
            //如果遍历查找类型为天干
            if(traverseType == SBTypeStems){
                //如果遍历条件符合，添加
                if([stems containsString:traverseConformStr]
                   ){
                    return name;
                }
            }
            //地支
            else{
                //如果遍历条件符合，添加
                if([branches containsString:traverseConformStr]
                   ){
                    return name;
                }
            }
            return nil;
        }];
    }
}

//遍历查找符合天干地支两者结合，如（四废）寅卯辰月，遇庚申、辛酉；要天干地支两者皆符合
-(void)traverseConformBothWithTraverseConformArr:(NSArray*)traverseConformArr
                                                          i:(NSInteger)i
                                                       name:(NSString*)name
                                conformCheckType:(MiddleSubViewType)conformCheckType
                                  branchToBranch:(BOOL)branchToBranch{
    //多个遍历条件中的一个
    NSString *traverseConformStrs = traverseConformArr[i];
    NSArray *traverseConformSubArr = [traverseConformStrs componentsSeparatedByString:@"、"];
    
    for(NSString* traverseConformStr in traverseConformSubArr){
        [self traverseWithCheckType:conformCheckType
                     branchToBranch:branchToBranch
                             result:^NSString*(NSString *stems,NSString *branches){
            if([traverseConformStr isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                return name;
            }
            return nil;
        }];
    }
}

//遍历只查找天干或者地支其中一个,只遍历查找底部日，时柱神煞
-(void)bottomDayHourTraverseConformStemsOrBranchesWithTraverseConformArr:(NSArray*)traverseConformArr
                                                          i:(NSInteger)i
                                               traverseType:(SBType)traverseType
                                                       name:(NSString*)name
                                                        conformCheckType:(MiddleSubViewType)conformCheckType{
    //多个遍历条件中的一个
    NSString *traverseConformStrs = traverseConformArr[i];
    //遍历条件可能包含多个干支，比如天乙的甲-(丑未)
    for(NSInteger k = 0;k<traverseConformStrs.length;k++){
        NSString* traverseConformStr = [traverseConformStrs substringWithRange:NSMakeRange(k, 1)];

        if(conformCheckType!=MiddleSubViewTypeDay){
            [self specifiedWithMiddleSubViewType:MiddleSubViewTypeDay
                                      shenShaArr:self.bottomDayShenShaArr
                                      judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                          if(traverseType == SBTypeStems){
                                              //如果遍历条件符合，添加
                                              if([stems containsString:traverseConformStr]
                                                 ){
                                                  return name;
                                              }
                                          }
                                          //地支
                                          else{
                                              //如果遍历条件符合，添加
                                              if([branches containsString:traverseConformStr]
                                                 ){
                                                  return name;
                                              }
                                          }
                                          return nil;
                                      }];
        }
        
        if(conformCheckType!=MiddleSubViewTypeHour){
            [self specifiedWithMiddleSubViewType:MiddleSubViewTypeHour
                                      shenShaArr:self.bottomHourShenShaArr
                                      judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                          if(traverseType == SBTypeStems){
                                              //如果遍历条件符合，添加
                                              if([stems containsString:traverseConformStr]
                                                 ){
                                                  return name;
                                              }
                                          }
                                          //地支
                                          else{
                                              //如果遍历条件符合，添加
                                              if([branches containsString:traverseConformStr]
                                                 ){
                                                  return name;
                                              }
                                          }
                                          return nil;
                                      }];
        }
        
    }
}

//遍历查找底部月和时符合天干地支两者结合，如（滚浪桃花）丙子日、见辛卯月或辛卯时】【辛卯日，见丙子月】滚浪桃花。
-(void)bottomMonthAndHourTraverseConformBothWithTraverseConformArr:(NSArray*)traverseConformArr
                                               i:(NSInteger)i
                                            name:(NSString*)name{
    //多个遍历条件中的一个
    NSString *traverseConformStrs = traverseConformArr[i];
    NSArray *traverseConformSubArr = [traverseConformStrs componentsSeparatedByString:@"、"];
    
    for(NSString* traverseConformStr in traverseConformSubArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeMonth
                                  shenShaArr:self.bottomMonthShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConformStr isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return name;
                                      }
                                      return nil;
                                  }];
        
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeHour
                                  shenShaArr:self.bottomHourShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConformStr isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return name;
                                      }
                                      return nil;
                                  }];
    }
}

//遍历查找底部月符合天干地支两者结合，如（滚浪桃花）丙子日、见辛卯月或辛卯时】【辛卯日，见丙子月】滚浪桃花。
-(void)bottomMonthTraverseConformBothWithTraverseConformArr:(NSArray*)traverseConformArr
                                                                 i:(NSInteger)i
                                                              name:(NSString*)name{
    //多个遍历条件中的一个
    NSString *traverseConformStrs = traverseConformArr[i];
    NSArray *traverseConformSubArr = [traverseConformStrs componentsSeparatedByString:@"、"];
    
    for(NSString* traverseConformStr in traverseConformSubArr){
        [self specifiedWithMiddleSubViewType:MiddleSubViewTypeMonth
                                  shenShaArr:self.bottomMonthShenShaArr
                                  judgeBlock:^NSString*(NSString *stems,NSString *branches){
                                      if([traverseConformStr isEqualToString:[NSString stringWithFormat:@"%@%@",stems,branches]]){
                                          return name;
                                      }
                                      return nil;
                                  }];
    }
}

@end
