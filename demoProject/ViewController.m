//
//  ViewController.m
//  demoProject
//
//  Created by alisha bhatia on 27/08/16.
//  Copyright © 2016 alisha bhatia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self registerNib];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)registerNib{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.frame = CGRectMake(20 + indexPath.row*40, 0, 30, 20);
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 40, 20)];
    if(indexPath.row == 0){
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    if(indexPath.row == 1){
        cell.backgroundColor = [UIColor greenColor];

    }
    if(indexPath.row == 2){
        cell.backgroundColor = [UIColor whiteColor];

    }
//    [cell.contentView addSubview:button];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height);
}


@end
