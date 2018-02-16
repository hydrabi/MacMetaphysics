//
//  BottomNormalTableViewHeader.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/15.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomColorLabel.h"
#import "BasicNibView.h"
@class GroupBottomXiaoYunView;
@interface BottomNormalTableViewHeader : BasicNibView

@property (nonatomic,weak)IBOutlet NSTextField *topTitleLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *mainTitleLabel;
@property (nonatomic,weak)IBOutlet NSTextField *bottomNumberTitleLabel;
@property (nonatomic,weak)IBOutlet NSTextField *hideTableViewButton;
@property (weak) IBOutlet NSTextField *bottomNumberButton;
@property (weak) IBOutlet NSTextField *ganButton;
@property (weak) IBOutlet NSTextField *zhiButton;
@property (nonatomic,assign)NSInteger tableViewTag;
@property (nonatomic,weak)GroupBottomXiaoYunView *parentGroupView;
-(void)reloadData;

@end
