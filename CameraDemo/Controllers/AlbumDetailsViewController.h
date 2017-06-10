//
//  AlbumDetailsViewController.h
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumDetailsViewController : UIViewController

/** 用于裁剪的原始图片 */
@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) void(^pictureSelectedBlock)();

@end
