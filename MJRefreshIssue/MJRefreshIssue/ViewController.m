//
//  ViewController.m
//  MJRefreshIssue
//
//  Created by dengliwen on 16/8/11.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "DemoCollectionCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[DemoCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
    
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 40 , 44);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;

    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self.view addSubview:self.collectionView];

    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor grayColor];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

@end
