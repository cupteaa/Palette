//
//  ViewController.m
//  Palette
//
//  Created by 于亚伟 on 2016/11/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

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
    
}
- (IBAction)savePictureToAlbum:(id)sender {
    
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
