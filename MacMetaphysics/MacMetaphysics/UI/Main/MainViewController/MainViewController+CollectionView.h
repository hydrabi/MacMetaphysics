//
//  MainViewController+CollectionView.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/10/5.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (CollectionView)<NSCollectionViewDelegate,NSCollectionViewDataSource>
-(void)collectionViewConfig;
@end
