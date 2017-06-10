//
//  PhotoClipView.h
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoClipView : UIView

/** 用于裁剪的原始图片 */
@property (strong, nonatomic) UIImage *image;

/** 重新拍照block */
@property (copy, nonatomic) void(^remakeBlock)();

/** 裁剪完成block */
@property (copy, nonatomic) void(^sureUseBlock)(UIImage *image);


@end
