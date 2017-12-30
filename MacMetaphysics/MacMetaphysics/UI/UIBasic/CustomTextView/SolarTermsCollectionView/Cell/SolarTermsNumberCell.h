//
//  SolarTermsNumberCell.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/28.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "SeparatorTableViewCell.h"

@interface SolarTermsNumberCell : SeparatorTableViewCell
@property (weak) IBOutlet NSTextField *titleLabel;
-(void)isCurrentSelectedDay:(BOOL)isSelected;
@end
