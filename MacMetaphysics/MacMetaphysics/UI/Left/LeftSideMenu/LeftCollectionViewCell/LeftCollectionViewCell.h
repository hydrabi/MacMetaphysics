//
//  LeftCollectionViewCell.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UIConstantParameter.h"
@interface LeftCollectionViewCell : NSCollectionViewItem
@property (weak) IBOutlet NSTextField *titleLabel;

-(void)resetValueWithType:(LeftSideMenuType)type;
@end
