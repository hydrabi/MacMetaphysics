//
//  SeparatorTableViewCell.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/27.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SeparatorTableViewCell : NSCollectionViewItem
@property (strong,nonatomic) NSBox *floorLineView;
@property (strong,nonatomic) NSBox *tailLineView;
-(void)showFloorLine;
-(void)hideFloorLine;
-(void)showTailLine;
-(void)hideTailLine;
@end
