//
//  WyzAlbumViewController.h
//
//  功能描述：用于显示并浏览图片，添加了加载进度条功能
//  Created by wyz on 15/10/18.
//  Copyright (c) 2015年 wyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WyzAlbumViewController : UIViewController
/**
 *  接收图片名称数组
 */
@property(nonatomic,strong) NSMutableArray  *imageNameArray;

/**
 *  接收图片数组，数组类型可以是url数组，image数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;
/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  显示名称
 */
@property(nonatomic, strong) UILabel *nameLabel;
/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;


@end
