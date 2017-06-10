//
//  PhotoClipView.m
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "PhotoClipView.h"
#import "PhotoClipCoverView.h"

@interface PhotoClipView ()

/** 图片 */
@property (strong, nonatomic) UIImageView *imageV;

/** 图片加载后的初始位置 */
@property (assign, nonatomic) CGRect norRect;

/** 裁剪框frame */
@property (assign, nonatomic) CGRect showRect;


@end

@implementation PhotoClipView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , self.frame.size.width, self.frame.size.width)];
    [self addSubview:self.imageV];

    PhotoClipCoverView *coverView = [[PhotoClipCoverView alloc] initWithFrame:self.bounds];
    [coverView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)]];
    [coverView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGR:)]];
    self.showRect = CGRectMake(1, self.frame.size.height * 0.15,self.frame.size.width - 2 ,self.frame.size.width - 2);
    coverView.showRect = self.showRect;
    [self addSubview:coverView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 60)];
    bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    [coverView addSubview:bottomView];
    
    //重拍
    UIButton *remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    remarkBtn.frame = CGRectMake(10, 15, 60, 30);
    [remarkBtn setTitle:@"重拍" forState:UIControlStateNormal];
    [remarkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    remarkBtn.backgroundColor = [UIColor clearColor];
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [remarkBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:remarkBtn];
    
    //使用照片
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(bottomView.frame.size.width - 90, 15, 80, 30);
    [sureBtn setTitle:@"使用照片" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor clearColor];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    
}

- (void)setImage:(UIImage *)image{
    
    if (image) {
        CGFloat ret = image.size.height / image.size.width;
        _imageV.height = _imageV.width * ret;
        _imageV.center = self.center;
        _norRect = _imageV.frame;
        _imageV.image = image;
    }
    
    _image = image;
    
}

- (void)panGR:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self];
    NSLog(@"%f %f",point.x,point.y);
    _imageV.center = CGPointMake(_imageV.centerX + point.x, _imageV.centerY + point.y);
    [sender setTranslation:CGPointZero inView:self];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3f animations:^{
            _imageV.frame = _norRect;
        }];
    }
}

- (void)pinGR:(UIPinchGestureRecognizer *)sender{
    
    _imageV.transform = CGAffineTransformScale(_imageV.transform, sender.scale, sender.scale);

    sender.scale = 1.0;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3f animations:^{
            _imageV.frame = _norRect;
        }];
    }
}


#pragma mark -- 重拍

- (void)leftButtonClicked{
    NSLog(@"重拍");
    if (self.remakeBlock) {
        self.remakeBlock();
    }
    
}

#pragma mark -- 使用照片

- (void)rightButtonClicked{
    NSLog(@"使用照片");
    
    CGFloat w = self.image.size.width;
    CGFloat h = self.image.size.height;

    CGFloat originX = (1- self.showRect.size.width / self.norRect.size.width) / 2.0 * w;
    CGFloat originY = (self.showRect.origin.y - self.norRect.origin.y) / self.norRect.size.height * h;
    CGFloat clipW = self.showRect.size.width / self.norRect.size.width * w;
    CGFloat clipH = self.showRect.size.height / self.norRect.size.height * h;
    
    CGRect clipRect = CGRectMake(originX, originY, clipW, clipH);
    UIImage *image = [self imageFromImage:self.image inRect:clipRect];

    _imageV.image = image;
    
    if (self.sureUseBlock) {
        self.sureUseBlock(image);
    }
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}


@end
