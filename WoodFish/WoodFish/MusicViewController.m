//
//  MusicViewController.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import "MusicViewController.h"
#import <Masonry/Masonry.h>
#import "CustomPlayer.h"

@interface MusicViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(50);
            make.size.mas_equalTo(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"Great Compassion Mantra";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(backBtn);
            make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.left.right.bottom.mas_equalTo(0);
}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.text = @"Chanting content";
            
            UILabel *contentLabel = [UILabel new];
            contentLabel.textAlignment = NSTextAlignmentRight;
            contentLabel.textColor = [UIColor orangeColor];
            contentLabel.font = [UIFont boldSystemFontOfSize:14];
            contentLabel.text = @"पुण्यप्रमाण +1";
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
                
            }];
            return cell;
        
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[CustomPlayer sharedInstance]playMusicWithName:@"C400004GY1Q82e7NJt.mp4"];
    
//    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"69037700097195916" withExtension:@"mp3"];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"69037700097195916" ofType:@"mp3"];
    NSData *data = [[NSData data]initWithContentsOfFile:filepath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    [player play];
    
//    NSError *error;
//    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
//
//    if (audioPlayer) {
//        [audioPlayer prepareToPlay];
//        [audioPlayer play];
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

@end
