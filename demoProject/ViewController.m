//
//  ViewController.m
//  demoProject
//
//  Created by alisha bhatia on 27/08/16.
//  Copyright © 2016 alisha bhatia. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#define open_weather_api_key @"1255ba5f70cf5adf3bd2ba9aaa7dd1dc"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *verticalCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.verticalCollectionView.delegate = self;
    self.verticalCollectionView.dataSource = self;

    [self registerNib];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)registerNib{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.verticalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellImage"];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(collectionView == self.collectionView)
        return 1;
    else
        return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.collectionView)
        return 3;
    else
        return 15;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.collectionView){
        UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0, self.collectionView.frame.size.width/2,self.collectionView.frame.size.height)];
        cell.backgroundColor = [self randomNiceColor];
        if(indexPath.row == 0){
            [button setTitle:@"Baha'i" forState:UIControlStateNormal];
        }
        if(indexPath.row == 1){
            [button setTitle:@"Baha'i1" forState:UIControlStateNormal];
        }
        if(indexPath.row == 2){
            [button setTitle:@"Baha'i2" forState:UIControlStateNormal];
        }
        [button setEnabled:NO];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:button];
        return cell;
    }
    else{
        UICollectionViewCell *cell = [self.verticalCollectionView dequeueReusableCellWithReuseIdentifier:@"cellImage" forIndexPath:indexPath];
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
        cell.backgroundColor = [self randomNiceColor];
        NSDictionary *parameters = @{@"q":@"Delhi",
                                     @"APPID":open_weather_api_key,
                                     @"units":@"metric"};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:@"http://api.openweathermap.org/data/2.5/weather" parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
            
            //Get Temprature
            id obj = [responseObject objectForKey:@"main"];
            NSString *temp = [obj objectForKey:@"temp"];
            NSInteger tempInt = [temp intValue];
            id obj1 = [responseObject objectForKey:@"weather"];
            NSString *temp1 = [obj1[0] objectForKey:@"main"];

            NSLog(@"tempname: %@", temp1);
            NSLog(@"tempInt: %ld", (long)tempInt);
            dispatch_async(dispatch_get_main_queue(), ^(){
                UILabel *temperatureNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 24, 100, 16)];
                temperatureNameLabel.text = temp1;
                [temperatureNameLabel setFont:[UIFont  systemFontOfSize:12 weight:UIFontWeightMedium]];
                temperatureNameLabel.textColor = [UIColor whiteColor];
                [cell.contentView addSubview:temperatureNameLabel];
            });
            
        
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 60, 60)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://c2.staticflickr.com/2/1107/3172320092_6d18a874b5.jpg"] placeholderImage:[UIImage imageNamed:@"defaultl_image"]];
        [cell.contentView addSubview:imageView];

        
        return cell;
    }

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.collectionView){
        return CGSizeMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height);
    }
    else{
        return CGSizeMake(self.verticalCollectionView.frame.size.width/2 - 3, self.verticalCollectionView.frame.size.height/4);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(collectionView == self.collectionView){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else{
        NSLog(@"section : %ld",(long)section);
        return UIEdgeInsetsMake(2, 2, 0, 2);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.collectionView){
        
    }
    else{
        
    }
}

- (UIColor *)randomNiceColor
{
    CGFloat hue = (arc4random() % 360) / 359.0f;
    CGFloat saturation = (float)arc4random() / UINT32_MAX;
    CGFloat brightness = (float)arc4random() / UINT32_MAX;
    saturation = saturation < 0.5 ? 0.5 : saturation;
    brightness = brightness < 0.9 ? 0.9 : brightness;
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:brightness
                           alpha:0.8];
}


@end
