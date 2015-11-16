//
//  ViewController.m
//  PhotoBrowser
//
//  Created by wyz on 15/10/26.
//  Copyright © 2015年 wyz. All rights reserved.
//

#import "ViewController.h"
#import "WyzAlbumViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSMutableArray  *imageNames;
@property(nonatomic,strong) NSMutableArray  *urlArrays;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlArrays=[[NSMutableArray alloc] init];
    self.imageNames=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    //第一种方式
    [self.urlArrays addObject:@"http://images.hongfanginv.com/2015/11/1447318757.jpg"];
    [self.urlArrays addObject:@"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg"];
    [self.urlArrays addObject:@"http://www.xxjxsj.cn/article/UploadPic/2009-10/200910321242159016.jpg"];
    [self.imageNames addObject:@"图片1"];
    [self.imageNames addObject:@"图片2"];
    [self.imageNames addObject:@"图片3"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showPhotoBrowser:0];
}

//显示图片浏览器
-(void)showPhotoBrowser:(NSInteger)index{
    WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    
    wyzAlbumVC.currentIndex =index;//这个参数表示当前图片的index，默认是0
    
    //图片数组，可以是url，也可以是UIImage
    //第一种用url
    wyzAlbumVC.imgArr = self.urlArrays;
    wyzAlbumVC.imageNameArray=self.imageNames;//图片名字数组可以为空
    //进入动画
    //    [self.navigationController pushViewController:wyzAlbumVC animated:NO];
    //    [self.navigationController.view.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1.0f];
    [self presentViewController:wyzAlbumVC animated:YES completion:^{
        
        
        
    }];
}

@end
