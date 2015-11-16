# PhotoBrwser
一个简单的好用的的图片浏览器
下载项目后解压把里面的PhotoBrowserFramework拷贝到项目中，如果是xocde7.0+，需要修改配置文件的的网络请求，否则无法下载图片

在Info.plist中添加  NSAppTransportSecurity 类型  Dictionary Dictionary 下添加  NSAllowsArbitraryLoads 类型 Boolean ,值设为  YES


实现了缩放功能，图片名称显示，只需要传两个参数即可，具体代码有说明

  WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    
    wyzAlbumVC.currentIndex =0;//这个参数表示当前图片的index，默认是0
    
    wyzAlbumVC.imgArr = self.urlArrays;//图片数组，可以是url，也可以是UIImage
    wyzAlbumVC.imageNameArray=self.imageNames;//图片名字数组可以为nil
    //进入动画
//    [self.navigationController pushViewController:wyzAlbumVC animated:NO];
//    [self.navigationController.view.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1.0f];
    [self presentViewController:wyzAlbumVC animated:YES completion:^{
    
    

    }];

