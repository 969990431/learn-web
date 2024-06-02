//
//  ViewController.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/16.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SetViewController.h"
#import <Masonry/Masonry.h>
#import "CYBScrollLabel.h"
#import "CYBTextView.h"
#import "CYBLunBoView.h"
#import "SelectMusicViewController.h"
#import "UserInfo.h"
#import <AudioToolbox/AudioToolbox.h>

#import <AFNetworking/AFNetworking.h>
#import "NSString+tool.h"
#import "WebViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong)UIImageView *muyuImageView;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) SystemSoundID soundFileObject;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIButton *zeroBtn;
@property (nonatomic, assign)int count;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong)UIButton *settingBtn;
@property (nonatomic, strong) CYBScrollLabel *musicNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;


@property (nonatomic, strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.muyuImageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-250)/2, screenHeight/2, 250, 250)];
    self.muyuImageView.image = [UIImage imageNamed:@"muyu"];
    
    [self.view addSubview:self.muyuImageView];
    UIGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    self.muyuImageView.userInteractionEnabled = YES;
    [self.muyuImageView addGestureRecognizer:tapG];
    
    //    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"muyu-2" ofType:@"mp3"];
    //        NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    //
    //        // 初始化 AVAudioPlayer
    //        NSError *error;
    //        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    //
    //        if (error) {
    //            NSLog(@"Error loading audio player: %@", error.localizedDescription);
    //        } else {
    ////            self.audioPlayer.numberOfLoops = -1;
    //            [self.audioPlayer prepareToPlay];
    //        }
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 150, 30)];
    [self.view addSubview:self.contentLabel];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.text = @"Merit accumulation";
    self.contentLabel.textColor = [UIColor orangeColor];
    self.contentLabel.font = [UIFont boldSystemFontOfSize:12];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, 150, 50)];
    [self.view addSubview:self.timeLabel];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = @"0";
    self.timeLabel.textColor = [UIColor orangeColor];
    self.timeLabel.font = [UIFont boldSystemFontOfSize:20];
    
    self.zeroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zeroBtn setTitle:@"Clear" forState:UIControlStateNormal];
    self.zeroBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.zeroBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.zeroBtn];
    self.zeroBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.zeroBtn.frame = CGRectMake(210, 50, 50, 30);
    self.zeroBtn.layer.masksToBounds = YES;
    self.zeroBtn.layer.cornerRadius = 15;
    [self.zeroBtn addTarget:self action:@selector(ClearClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [self.view addSubview:self.settingBtn];
    self.settingBtn.frame = CGRectMake(screenWidth-60, 50, 40, 40);
    [self.settingBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    
    //无限滚动View
    self.musicNameLabel = [[CYBScrollLabel alloc]initWithFrame:CGRectMake(50, 50, 200, 40)];
    self.musicNameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMusic)];
    [self.musicNameLabel addGestureRecognizer:tap];
    self.musicNameLabel.layer.masksToBounds = YES;
    self.musicNameLabel.layer.cornerRadius = 20;
    self.musicNameLabel.textColor = [UIColor whiteColor];
    self.musicNameLabel.backgroundColor = [UIColor orangeColor];
    self.musicNameLabel.text = @"🎵 Listen to Buddhist sutras";
    [self.view addSubview:self.musicNameLabel];
    [self.musicNameLabel startScoll];
    [self.musicNameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-80);
        make.size.mas_equalTo(CGSizeMake(screenWidth-100, 40));
    }];
    
    
    
}


// 读取图像并修改非透明部分颜色的方法
- (UIImage *)modifyImageColor:(UIImage *)image withColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 在图形上下文中绘制原始图像
    [image drawInRect:rect];
    
    // 获取图像的像素数据
    CGImageRef imageRef = image.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef contextRef = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(contextRef, rect, imageRef);
    
    // 遍历像素数据并修改非透明部分的颜色
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    for (int i = 0; i < height * width; i++) {
        UInt8 *rgbaPixel = (UInt8 *) &rawData[i * 4];
        if (rgbaPixel[3] > 0) {
            rgbaPixel[0] = (UInt8) (red * 255);
            rgbaPixel[1] = (UInt8) (green * 255);
            rgbaPixel[2] = (UInt8) (blue * 255);
        }
    }
    
    // 创建修改后的图像
    CGImageRef modifiedImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *modifiedImage = [UIImage imageWithCGImage:modifiedImageRef scale:image.scale orientation:image.imageOrientation];
    
    // 释放内存
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(contextRef);
    free(rawData);
    CGImageRelease(modifiedImageRef);
    
    UIGraphicsEndImageContext();
    
    return modifiedImage;
}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"-----%@", [UserInfo sharedInstance].count);
    if([UserInfo sharedInstance].count.length) {
        self.count = [[UserInfo sharedInstance].count intValue];
        self.timeLabel.text = [UserInfo sharedInstance].count;
    }else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d", self.count];
    }
    
    if([UserInfo sharedInstance].playingIndex.length) {
        self.musicNameLabel.text = [NSString stringWithFormat:@"🎵 Great Compassion Mantra%@ is playing", [UserInfo sharedInstance].playingIndex];
    }else {
        self.musicNameLabel.text = [NSString stringWithFormat:@"🎵 Listen to Buddhist sutras"];
    }
    
    if([[UserInfo sharedInstance].isDisplayCount isEqualToString:@"yes"]) {
        self.contentLabel.hidden = YES;
        self.timeLabel.hidden = YES;
        self.zeroBtn.hidden = YES;
    }else {
        self.contentLabel.hidden = NO;
        self.timeLabel.hidden = NO;
        self.zeroBtn.hidden = NO;
    }
    
    if([[UserInfo sharedInstance].knockPattern isEqualToString:@"no"]) {
        //        自动
        if(!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [self click];
            }];
        }
    }else {
        //        手动
        [self.timer invalidate];
        self.timer = nil;
    }
    if([UserInfo sharedInstance].selectColorIndex.intValue > 0) {
        NSArray *colors = @[[UIColor redColor], [UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor blueColor],[UIColor purpleColor]];
        
        UIImage *modifiedImage = [self modifyImageColor:[UIImage imageNamed:@"muyu"] withColor:colors[[UserInfo sharedInstance].selectColorIndex.intValue-1]];
        self.muyuImageView.image = modifiedImage;
        
    }else {
        self.muyuImageView.image = [UIImage imageNamed:@"muyu"];
    }
    
//    [self loadData];
}

- (void)loadData {
    // 创建 AFHTTPSessionManager 对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 设置请求参数
    NSDictionary *parameters = @{@"appkey":@"22a1822f04e08d0d9ef7f87026c29a6f"};

    [manager POST:@"https://api.gilet.ceshi.in/api/v1/app/qweqwe" parameters:parameters headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---%@", [NSString decrypt:responseObject[@"data"] key:@"jaix8WnfqRFpQlLk"]);
        
        NSError *error;
        NSData *jsonData = [[NSString decrypt:responseObject[@"data"] key:@"jaix8WnfqRFpQlLk"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"===%@", jsonDictionary);
        
        if([jsonDictionary[@"iswap"]intValue] == 1) {
            WebViewController *webVC = [WebViewController new];
            webVC.modalPresentationStyle = UIModalPresentationFullScreen;
            webVC.urlString = jsonDictionary[@"wapurl"];
//            [self presentViewController:webVC animated:YES completion:nil];
        }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

}
- (void)selectMusic {
    SelectMusicViewController *vc = [SelectMusicViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)click {
    self.count ++;
    [UserInfo sharedInstance].count = [NSString stringWithFormat:@"%d", self.count];
    NSLog(@"====%@",[UserInfo sharedInstance].count);
    self.timeLabel.text = [NSString stringWithFormat:@"%d", self.count];
    [self shakeToShow:self.muyuImageView];
    
    
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"muyu-2" ofType:@"mp3"];
    NSURL *audioFileURL = [NSURL fileURLWithPath:audioFilePath];
    
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioFileURL, &_soundFileObject);
    AudioServicesPlaySystemSound(_soundFileObject);
    
    if (@available(iOS 10.0, *)) {
        if([[UserInfo sharedInstance].vibTouch isEqualToString:@"no"]) {
//            UIImpactFeedbackGenerator *feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
//            [feedbackGenerator prepare];
//            [feedbackGenerator impactOccurred];
            
            AudioServicesPlaySystemSound(1520);
        }else {
            UIImpactFeedbackGenerator *feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
                    [feedbackGenerator prepare];
        }
    }
    
    if(![[UserInfo sharedInstance].isDisplayChantingString isEqualToString:@"yes"]) {
        
        [self animateLabel];
    }
    
}


- (void)animateLabel {
    // 创建一个新的Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight/2, screenWidth, 50)];
    //    𑖌𑖼𑖦𑖜𑖰𑖢𑖟𑖿𑖦𑖸𑖮𑖳𑖽
    label.text = [UserInfo sharedInstance].chantingString ? [UserInfo sharedInstance].chantingString:@"पुण्यप्रमाण +1";
    //    label.text = @"पुण्यप्रमाण +1";
    label.font = [UIFont italicSystemFontOfSize:40];
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 1.0;
    [self.view addSubview:label];
    
    // 执行动画
    [UIView animateWithDuration:2.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, -screenHeight/2);
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview]; // 移除Label
    }];
}


- (void) shakeToShow:(UIView *)aView
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.1;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    // 前两个是控制view的大小的；
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)ClearClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Prompt" message:@"Clear count?" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.count = 0;
        self.timeLabel.text = @"0";
        [UserInfo sharedInstance].count = @"0";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
}

- (void)setClick {
    SetViewController *setvc = [SetViewController new];
    //    [self.navigationController pushViewController:setvc animated:YES];
    setvc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:setvc animated:YES completion:^{
        
    }];
}
@end
