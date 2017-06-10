//
//  PhotoCaptureViewController.m
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "PhotoCaptureViewController.h"
#import "TakePhotoViewController.h"
#import "AlbumViewController.h"

@interface PhotoCaptureViewController ()

@end

@implementation PhotoCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(0, 0, 200, 50);
    cameraBtn.center = self.view.center;
    cameraBtn.backgroundColor = [UIColor redColor];
    cameraBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cameraBtn setTitle:@"获取图片" forState:UIControlStateNormal];
    [cameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraBtn];
}

- (void)buttonClicked{
    
    UIAlertController *aController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *takePhotoBtn = [UIAlertAction actionWithTitle:@"拍 照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        TakePhotoViewController *uitpVC = [TakePhotoViewController new];
        uitpVC.takePhotoBlock = ^(UIImage *photoImage) {
            
            NSLog(@"%@",photoImage);
        };
        [self presentViewController:uitpVC animated:YES completion:nil];
        
    }];
    
    UIAlertAction *albumBtn = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AlbumViewController *albumVC = [AlbumViewController new];
        [self.navigationController pushViewController:albumVC animated:YES];
        
    }];
    
    [aController addAction:cancelBtn];
    [aController addAction:takePhotoBtn];
    [aController addAction:albumBtn];
    
    [self presentViewController:aController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
