//
//  UserInfo.h
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, copy)NSString *playingIndex;

@property (nonatomic, copy)NSString *count;
@property (nonatomic, copy)NSString *chantingString;
@property (nonatomic, copy)NSString *isDisplayChantingString;
@property (nonatomic, copy)NSString *isDisplayCount;
@property (nonatomic, copy)NSString *knockPattern;
@property (nonatomic, copy)NSString *vibTouch;
@property (nonatomic, copy)NSString *selectColorIndex;

@end

NS_ASSUME_NONNULL_END
