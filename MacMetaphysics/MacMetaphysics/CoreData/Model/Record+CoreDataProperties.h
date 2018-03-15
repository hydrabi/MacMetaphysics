//
//  Record+CoreDataProperties.h
//  
//
//  Created by zhihuihl on 2018/3/14.
//
//

#import "Record+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

+ (NSFetchRequest<Record *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *key;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *other;
@property (nullable, nonatomic, copy) NSString *ganZhiYear;
@property (nullable, nonatomic, copy) NSString *ganZhiMonth;
@property (nullable, nonatomic, copy) NSString *ganZhiDay;
@property (nullable, nonatomic, copy) NSString *ganZhiHour;
@property (nonatomic) int16_t gregorianYear;
@property (nonatomic) int16_t gregorianMonth;
@property (nonatomic) int16_t gregorianDay;
@property (nonatomic) int16_t gregorianHour;

@end

NS_ASSUME_NONNULL_END
