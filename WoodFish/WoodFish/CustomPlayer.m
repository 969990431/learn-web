//
//  CustomPlayer.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import "CustomPlayer.h"

@implementation CustomPlayer
+ (instancetype)sharedInstance {
    static CustomPlayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)playMusicWithName:(NSString *)musicName {
    AVAudioSession * session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:musicName withExtension:@"mp4"];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    self.audioPlayer.numberOfLoops = 1000;
    if (self.audioPlayer) {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    } else {
        NSLog(@"Failed to play music: %@", error.localizedDescription);
    }
}

- (void)stopMusic {
    [self.audioPlayer stop];
}
@end
