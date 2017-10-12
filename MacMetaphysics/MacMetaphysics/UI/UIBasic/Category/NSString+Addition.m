//
//  NSString+Addition.m
//  Metaphysics
//
//  Created by Hydra on 2017/2/1.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+ (NSString *)convertToIconTextWithHexString:(NSString *)hexStr{
    
    if (!hexStr) {
        return @"";
    }
    //1.将json中的iconText 转换成16进制
    unsigned long hex = strtoul([hexStr UTF8String], 0, 16);
    //2.将16进制强制转换成unsigned short
    unichar ll = hex;
    
    //3.在转成NSString
    return [[NSString alloc] initWithCharacters:&ll length:1];
    
}

+(NSString*)stemsStr{
    return @"甲乙丙丁戊己庚辛壬癸";
}

+(NSString*)branchesStr{
    return @"子丑寅卯辰巳午未申酉戌亥";
}

+(NSString*)shiChenWithTime:(NSInteger)time{
    NSString *shiChen = @"";
    switch (time) {
        case 23:
        case 0:
        {
            shiChen = @"子";
        }
            break;
        case 1:
        case 2:
        {
            shiChen = @"丑";
        }
            break;
        case 3:
        case 4:
        {
            shiChen = @"寅";
        }
            break;
        case 5:
        case 6:
        {
            shiChen = @"卯";
        }
            break;
        case 7:
        case 8:
        {
            shiChen = @"辰";
        }
            break;
        case 9:
        case 10:
        {
            shiChen = @"巳";
        }
            break;
        case 11:
        case 12:
        {
            shiChen = @"午";
        }
            break;
        case 13:
        case 14:
        {
            shiChen = @"未";
        }
            break;
        case 15:
        case 16:
        {
            shiChen = @"申";
        }
            break;
        case 17:
        case 18:
        {
            shiChen = @"酉";
        }
            break;
        case 19:
        case 20:
        {
            shiChen = @"戌";
        }
            break;
        case 21:
        case 22:
        {
            shiChen = @"亥";
        }
            break;
            
        default:
            break;
    }
    return shiChen;
}

//        子    丑    寅    卯    辰    巳    午    未    申    酉    戌    亥
//甲己    甲子、乙丑、丙寅、丁卯、戊辰、己巳、庚午、辛未、壬申、癸酉、甲戌、乙亥、
//乙庚    丙子、丁丑、戊寅、己卯、庚辰、辛巳、壬午、癸未、甲申、乙酉、丙戌、丁亥、
//丙辛    戊子、己丑、庚寅、辛卯、壬辰、癸巳、甲午、乙未、丙申、丁酉、戊戌、己亥、
//丁壬    庚子、辛丑、壬寅、癸卯、甲辰、乙巳、丙午、丁未、戊申、己酉、庚戌、辛亥、
//戊癸    壬子、癸丑、甲寅、乙卯、丙辰、丁巳、戊午、己未、庚申、辛酉、壬戌、癸亥、
+(NSString*)ganZhiHourWithHour:(NSInteger)hour day:(NSString*)day{
    NSString *ganZhiHour = @"";
    //地支
    NSString *branchesStr = [self branchesStr];
    //天干
    NSString *stemsStr = [self stemsStr];
    //时间对应的时辰
    NSString *shiChen = [self shiChenWithTime:hour];
    //时辰处于地支的索引
    NSInteger shiChenIndex = [branchesStr rangeOfString:shiChen].location;
    //日上起时发相应天干对应的延后匹配索引
    NSUInteger startIndex = 0;
    if([day containsString:@"甲"] ||
       [day containsString:@"己"]){
        startIndex = 0;
    }
    else if([day containsString:@"乙"] ||
            [day containsString:@"庚"]){
        startIndex = 2;
    }
    else if([day containsString:@"丙"] ||
            [day containsString:@"辛"]){
        startIndex = 4;
    }
    else if([day containsString:@"丁"] ||
            [day containsString:@"壬"]){
        startIndex = 6;
    }
    else if([day containsString:@"戊"] ||
            [day containsString:@"癸"]){
        startIndex = 8;
    }
    //求余后获得真正对应的匹配天干的位置
    NSUInteger realIndex = (shiChenIndex + startIndex) % (stemsStr.length);
    //组合两者，获得时的干支
    ganZhiHour = [NSString stringWithFormat:@"%@%@",[stemsStr substringWithRange:NSMakeRange(realIndex, 1)],shiChen];
    return ganZhiHour;
}

-(NSString*)getStems{
    NSAssert(self.length == 2, @"干支长度不为2");
    return [self substringWithRange:NSMakeRange(0, 1)];
}

-(NSString*)getBranches{
    NSAssert(self.length == 2, @"干支长度不为2");
    return [self substringWithRange:NSMakeRange(1, 1)];
}

-(BOOL)isStemsYang{
    NSAssert(self.length == 1, @"天干长度不为1");
    NSAssert([[NSString stemsStr] containsString:self], @"不属于天干");
    NSInteger index = [[NSString stemsStr] rangeOfString:self].location;
    //甲乙丙丁戊己庚辛壬癸 相对应为阳阴阳阴阳阴阳阴
    if(index % 2 == 0){
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)isBranchesYang{
    NSAssert(self.length == 1, @"地支长度不为1");
    NSAssert([[NSString branchesStr] containsString:self], @"不属于地支");
    NSInteger index = [[NSString branchesStr] rangeOfString:self].location;
    //子丑寅卯辰巳午未申酉戌亥 相对应为阳阴阳阴阳阴阳阴阳阴
    if(index % 2 == 0){
        return YES;
    }
    else{
        return NO;
    }
}

+(NSString*)getValueWithType:(liuQinType)type{
    NSString *result = @"";
    switch (type) {
        case liuQinType_Bi:
            result = @"比";
            break;
        case liuQinType_Jie:
            result = @"劫";
            break;
        case liuQinType_Xiao:
            result = @"枭";
            break;
        case liuQinType_Yin:
            result = @"印";
            break;
        case liuQinType_CaiFu:
            result = @"财";
            break;
        case liuQinType_CaiHua:
            result = @"才";
            break;
        case liuQinType_Sha:
            result = @"杀";
            break;
        case liuQinType_Guan:
            result = @"官";
            break;
        case liuQinType_Shi:
            result = @"食";
            break;
        case liuQinType_Shang:
            result = @"伤";
            break;
        default:
            break;
    }
    return result;
}

@end
