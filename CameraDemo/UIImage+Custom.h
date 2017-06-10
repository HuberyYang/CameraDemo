//
//  UIImage+Custom.h
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Custom)

/** 两种方法都是处理图片默认方向，使其向上 */

- (UIImage *)normalizedImage;

- (UIImage *)fixOrientation;

@end
