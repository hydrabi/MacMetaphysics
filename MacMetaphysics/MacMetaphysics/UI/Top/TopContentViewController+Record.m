//
//  TopContentViewController+Record.m
//  MacMetaphysics
//
//  Created by zhihuihl on 2018/3/30.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "TopContentViewController+Record.h"
#import "Record+CoreDataProperties.h"
@implementation TopContentViewController (Record)

-(void)fillTextViewWithRecord:(Record*)record{
    self.firstTextField.text = record.name?:@"";
    self.secondTextField.text = record.other?:@"";
    self.thirdTextField.text = record.key?:@"";
}

@end
