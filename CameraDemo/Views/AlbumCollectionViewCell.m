//
//  AlbumCollectionViewCell.m
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "AlbumCollectionViewCell.h"

@interface AlbumCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageV;

@end

@implementation AlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
     
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageV];
    }
    
    return self;
}


- (void)updateCollectionViewCellInformationWithData:(UIImage *)image{
    
    _imageV.image = image;
}

@end
