//
//  TakePhotoViewController.h
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewController : UIViewController

@property (copy, nonatomic) void(^takePhotoBlock)(UIImage *photoImage);

@end
