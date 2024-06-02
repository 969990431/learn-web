//
//  MusicPlayer.h
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPlayer : NSObject
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

+ (instancetype)sharedInstance;
- (void)playMusicWithName:(NSString *)musicName;
- (void)stopMusic;
@end

NS_ASSUME_NONNULL_END
