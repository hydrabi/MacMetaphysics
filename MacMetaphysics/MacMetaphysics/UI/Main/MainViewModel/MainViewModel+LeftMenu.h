//
//  MainViewModel+LeftMenu.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/6.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewModel.h"

@interface MainViewModel (LeftMenu)

-(NSString*)getSpecificMenuTitleWithType:(LeftSideMenuType)type;
-(LeftSideMenuType)getSpecificMenuTypeWithIndexPath:(NSIndexPath*)indexPath;
-(void)selectMunuWithIndexPath:(NSIndexPath*)indexPath;
@end
