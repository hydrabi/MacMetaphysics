//
//  SolarTermsCollectionView.h
//  MacMetaphysics
//
//  Created by Hydra on 2017/12/30.
//  Copyright © 2017年 毕志锋. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SolarTermsCollectionView;
@interface SolarTermsCollectionViewDataSource : NSObject<NSCollectionViewDelegateFlowLayout,NSCollectionViewDataSource,NSCollectionViewDelegate>
@property (nonatomic,weak)SolarTermsCollectionView *collectionView;
@end

/**
 节气视图
 */
@interface SolarTermsCollectionView : NSCollectionView
@property (nonatomic,strong)SolarTermsCollectionViewDataSource *myDataSource;
+(SolarTermsCollectionView*)createSolarTermsCollectionView;
@end
