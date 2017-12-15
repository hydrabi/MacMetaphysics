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
@interface BottomNormalTableViewHeader : BasicNibView

@property (nonatomic,weak)IBOutlet NSTextField *topTitleLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *mainTitleLabel;
@property (nonatomic,weak)IBOutlet NSTextField *bottomNumberTitleLabel;
@property (nonatomic,weak)IBOutlet NSTextField *hideTableViewButton;
@property (nonatomic,assign)NSInteger tableViewTag;

-(void)reloadData;

@end
