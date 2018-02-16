//
//  FifteenYunTitleView.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "BasicNibView.h"

@interface FifteenYunTitleView : BasicNibView
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *textField;
-(void)reloadData;
@end
