//
//  SingleBottomXiaoYunView.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/12.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BasicNibView.h"
#import "CustomColorLabel.h"
@class GroupBottomXiaoYunView;
/**
 单个流年view
 */
@interface SingleBottomXiaoYunView : BasicNibView

@property (nonatomic,weak)IBOutlet NSTextField *yearLabel;
@property (nonatomic,weak)IBOutlet NSTextField *liuNianLabel;
@property (nonatomic,weak)GroupBottomXiaoYunView *parentGroupView;
@property (nonatomic,assign)NSInteger myTag;

-(void)hideContent;
-(void)showContent;
-(void)selectCell:(BOOL)select;
@end
