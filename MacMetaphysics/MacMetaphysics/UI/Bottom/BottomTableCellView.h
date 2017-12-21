//
//  BottomTableCellView.h
//  MacMetaphysics
//
//  Created by zhihuihl on 2017/12/21.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomColorLabel.h"
#import "BasicNibView.h"
@interface BottomTableCellView : BasicNibView

@property (nonatomic,weak)IBOutlet NSTextField *yearLabel;
@property (nonatomic,weak)IBOutlet CustomColorLabel *liuNianLabel;

-(void)hideContent;
-(void)showContent;
-(void)selectCell:(BOOL)select;

@end
