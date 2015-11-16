//
//  PhotoView.h
//
//  Created by wyz on 15/10/18.
//  Copyright (c) 2015年 wyz. All rights reserved.
//

#import <UIKit/UIKit.h>
//1.
@protocol PhotoViewDelegate <NSObject>

//点击图片时，隐藏图片浏览器
-(void)TapHiddenPhotoView;

@end

@interface PhotoView : UIView
/**
 *  添加的图片
 */
@property(nonatomic, strong) UIImageView *imageView;
//2.
/**
 *  代理
 */
@property(nonatomic, assign) id<PhotoViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl;

-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image;



@end
