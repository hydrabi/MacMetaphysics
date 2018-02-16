//
//  FifteenYunCollectionViewItem.h
//  MacMetaphysics
//
//  Created by Hydra on 2018/2/16.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FifteenYunCollectionViewItem : NSCollectionViewItem
@property (weak) IBOutlet NSTextField *yearLabel;
@property (weak) IBOutlet NSTextField *liuNianLabel;
@property (weak) IBOutlet NSTextField *xiaoYunLabel;
-(void)resetValueWithIndexPath:(NSIndexPath*)indexPath;
@end
