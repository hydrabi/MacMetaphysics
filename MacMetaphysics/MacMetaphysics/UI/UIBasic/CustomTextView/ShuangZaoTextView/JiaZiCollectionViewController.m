//
//  JiaZiCollectionViewController.m
//  MacMetaphysics
//
//  Created by Hydra on 2018/1/14.
//  Copyright © 2018年 毕志锋. All rights reserved.
//

#import "JiaZiCollectionViewController.h"

@interface JiaZiCollectionViewController ()

@end

@implementation JiaZiCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollecitonView];
    [self layoutMySubView];
//    NSCollectionViewFlowLayout *layout = (NSCollectionViewFlowLayout*)self.collectionView.;
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.itemSize = CGSizeMake(jiaZiCellWidth,
//                                 jiaZiCellHeight);
//    layout.minimumLineSpacing = jiaZiCellOffset;
//    layout.minimumInteritemSpacing = jiaZiCellOffset;
//    layout.sectionInset = UIEdgeInsetsMake(jiaZiCellOffset,
//                                           jiaZiCellOffset,
//                                           jiaZiCellOffset,
//                                           jiaZiCellOffset);
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JiaZiCollectionViewCell class])
//                                                    bundle:nil]
//          forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)setUpCollecitonView{
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.sectionInset = NSEdgeInsetsZero;
    self.collectionView = [[NSCollectionView alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    [self.view addSubview:self.collectionView];
}

-(void)layoutMySubView{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
}

@end
