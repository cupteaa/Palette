//
//  ViewController.m
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ImageHandleView.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (weak, nonatomic) IBOutlet UISlider *lineWidth;

@end

@implementation ViewController

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)earse:(id)sender {
    self.drawView.lineWidth = 5;
    self.drawView.pathColor = [UIColor whiteColor];
}
- (IBAction)stateReset:(id)sender {
    self.drawView.pathColor = [UIColor blackColor];
    self.drawView.lineWidth = 1;
    self.lineWidth.value = 1;
 
}
- (IBAction)PickPictureFromAlbum:(id)sender {
    // 弹出相册
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc] init];
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;// 照片库
    
    pickerVc.delegate = self;
    // modal
    [self presentViewController:pickerVc animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>
// 当用户从相册中选择一张照片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"picked a picture");
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 创建一个处理图片的view
    ImageHandleView *handleView = [[ImageHandleView alloc] initWithFrame:self.drawView.bounds];
    handleView.handleCompletionBlock = ^(UIImage *image){
        self.drawView.image = image;
    };
    handleView.image = image;
    [self.drawView addSubview:handleView];
//    self.drawView.image = image;
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePictureToAlbum:(id)sender {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 将控件的图层渲染到上下文中
    [self.drawView.layer renderInContext:ctx];
    // 获取新的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 将图片保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
// 监听保存成功,必须实现这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"图片保存成功");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)colorChange:(UIButton *)sender {
    // 颜色改变
    self.drawView.pathColor = sender.backgroundColor;
}
- (IBAction)lineWidth:(UISlider *)sender {
    self.drawView.lineWidth = sender.value;
    
}


@end
