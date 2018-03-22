//
//  Record+CoreDataProperties.m
//  
//
//  Created by zhihuihl on 2018/3/14.
//
//

#import "Record+CoreDataProperties.h"

@implementation Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Record"];
}

@dynamic key;
@dynamic name;
@dynamic other;
@dynamic ganZhiYear;
@dynamic ganZhiMonth;
@dynamic ganZhiDay;
@dynamic ganZhiHour;
@dynamic gregorianYear;
@dynamic gregorianMonth;
@dynamic gregorianDay;
@dynamic gregorianHour;
@dynamic lunarYear;
@dynamic lunarMonth;
@dynamic lunarDay;
@dynamic lunarHour;

@end
