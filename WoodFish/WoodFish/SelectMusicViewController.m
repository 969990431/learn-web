//
//  MusicViewController.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import "SelectMusicViewController.h"
#import <Masonry/Masonry.h>
#import "CustomPlayer.h"
#import "UserInfo.h"

@interface SelectMusicViewController ()<UITableViewDelegate, UITableViewDataSource,AVAudioPlayerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, strong)UIButton *playBtn;
@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, assign)BOOL isPlaying;
@property (nonatomic, assign)NSInteger playingIndex;
@end

@implementation SelectMusicViewController

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
    titleLabel.textColor = [UIColor grayColor];
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
    
    
    self.progress = [[UIProgressView alloc]init];
    self.progress.tintColor = [UIColor orangeColor];
    self.progress.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.progress];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
            make.right.mas_equalTo(-70);
        make.left.mas_equalTo(70);
            make.height.mas_equalTo(3);
    }];
    
    self.isPlaying = [CustomPlayer sharedInstance].audioPlayer.isPlaying;
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn setImage:[UIImage imageNamed:[CustomPlayer sharedInstance].audioPlayer.isPlaying ?@"pause":@"play"] forState:UIControlStateNormal];
    [self.view addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.progress);
            make.size.mas_equalTo(30);
    }];
    
    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"00:00/4:00";

    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:8];
    [self.view addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playBtn);
            make.right.mas_equalTo(-10);
    }];
    
    if(!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.progress.progress = [CustomPlayer sharedInstance].audioPlayer.currentTime/[CustomPlayer sharedInstance].audioPlayer.duration;
            NSInteger intC = (NSInteger)[CustomPlayer sharedInstance].audioPlayer.currentTime;
            NSInteger intD = (NSInteger)[CustomPlayer sharedInstance].audioPlayer.duration;

            self.timeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld/%.2ld:%.2ld",intC / 60,intC % 60,intD / 60, intD % 60];

        }];
    }
    
}
- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"🎵🎵";
            
    
    
            UILabel *contentLabel = [UILabel new];
            contentLabel.textAlignment = NSTextAlignmentRight;
            contentLabel.textColor = [UIColor orangeColor];
            contentLabel.font = [UIFont boldSystemFontOfSize:14];
            contentLabel.text = [NSString stringWithFormat:@"Great Compassion Mantra%ld", indexPath.row+1];
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(-14);
                
            }];
    
    UIImageView *playingImageV = [UIImageView new];
    playingImageV.hidden = YES;
    playingImageV.image = [UIImage imageNamed:@"pause"];
    [cell.contentView addSubview:playingImageV];
    [playingImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell);
            make.left.mas_equalTo(80);
            make.size.mas_equalTo(15);
    }];
    
    if([UserInfo sharedInstance].playingIndex.length && indexPath.row == [UserInfo sharedInstance].playingIndex.intValue-1) {
        playingImageV.hidden = NO;
    }else {
        playingImageV.hidden = YES;
    }
            return cell;
        
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.playingIndex = indexPath.row;
    [UserInfo sharedInstance].playingIndex = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    self.isPlaying = YES;
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [[CustomPlayer sharedInstance]playMusicWithName:[NSString stringWithFormat:@"Great Compassion Mantra%ld", indexPath.row+1]];
    [CustomPlayer sharedInstance].audioPlayer.delegate = self;
    [self.tableView reloadData];
    if(!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.progress.progress = [CustomPlayer sharedInstance].audioPlayer.currentTime/[CustomPlayer sharedInstance].audioPlayer.duration;
            NSInteger intC = (NSInteger)[CustomPlayer sharedInstance].audioPlayer.currentTime;
            NSInteger intD = (NSInteger)[CustomPlayer sharedInstance].audioPlayer.duration;

            self.timeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld/%.2ld:%.2ld",intC / 60,intC % 60,intD / 60, intD % 60];

        }];
    }
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

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [self.playBtn setImage:[UIImage imageNamed:player.isPlaying ? @"pause":@"play"] forState:0];
    
}

- (void)playClick {
    if(self.isPlaying) {
        [[CustomPlayer sharedInstance].audioPlayer pause];
    }else {
        [[CustomPlayer sharedInstance].audioPlayer play];
    }

//    dispatch_async(dispatch_get_main_queue(), ^{
        
    [self.playBtn setImage:[UIImage imageNamed:self.isPlaying ? @"play":@"pause"] forState:UIControlStateNormal];
        self.isPlaying = !self.isPlaying;
//    });
    
    
}
@end
