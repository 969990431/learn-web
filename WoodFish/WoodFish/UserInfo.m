//
//  UserInfo.m
//  WoodFish
//
//  Created by Yangjiakui on 2023/5/17.
//

#import "UserInfo.h"

@interface UserInfo (){
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;

    // 用户数据中心，可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
}

@end
@implementation UserInfo
- (instancetype)init {
    self  = [super init];
    if(self) {
        // 通过宏定义 DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
                concurrent_queue = dispatch_queue_create("read_write_queue",DISPATCH_QUEUE_CONCURRENT);
                // 创建数据容器
                userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}
+ (instancetype)sharedInstance {
    static UserInfo *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserInfo alloc] init];
    });
    return sharedInstance;
}
- (void)setPlayingIndex:(NSString *)playingIndex {
    [self saveToNSDefaultsWithKey:@"playingIndex"obj:playingIndex];
}
- (NSString *)playingIndex {
    return [self readToNSDefaultsWithKey:@"playingIndex"];
}
- (void)setCount:(NSString *)count {
    dispatch_barrier_async(concurrent_queue, ^{
        [self saveToNSDefaultsWithKey:@"count"obj:count];
        });
}
- (NSString *)count {
    __block NSString *obj;
    dispatch_sync(concurrent_queue,^{
            obj = [self readToNSDefaultsWithKey:@"count"];
        });
    return obj;
}
- (void)setChantingString:(NSString *)chantingString {
    [self saveToNSDefaultsWithKey:@"chantingString"obj:chantingString];
}
- (NSString *)chantingString {
    return [self readToNSDefaultsWithKey:@"chantingString"];
}
- (void)setIsDisplayChantingString:(NSString *)isDisplayChantingString {
    [self saveToNSDefaultsWithKey:@"isDisplayChantingString"obj:isDisplayChantingString];
}
- (NSString *)isDisplayChantingString {
    return [self readToNSDefaultsWithKey:@"isDisplayChantingString"];
}
- (void)setIsDisplayCount:(NSString *)isDisplayCount {
    [self saveToNSDefaultsWithKey:@"isDisplayCount"obj:isDisplayCount];
}
- (NSString *)isDisplayCount {
    return [self readToNSDefaultsWithKey:@"isDisplayCount"];
}
- (void)setKnockPattern:(NSString *)knockPattern {
    [self saveToNSDefaultsWithKey:@"knockPattern"obj:knockPattern];
}
- (NSString *)knockPattern {
    return [self readToNSDefaultsWithKey:@"knockPattern"];
}
- (void)setVibTouch:(NSString *)vibTouch {
    [self saveToNSDefaultsWithKey:@"vibTouch"obj:vibTouch];
}
- (NSString *)vibTouch {
    return [self readToNSDefaultsWithKey:@"vibTouch"];
}
- (void)setSelectColorIndex:(NSString *)selectColorIndex {
    [self saveToNSDefaultsWithKey:@"selectColorIndex" obj:selectColorIndex];
}
- (NSString *)selectColorIndex {
    return [self readToNSDefaultsWithKey:@"selectColorIndex"];
}
#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key obj: (NSString *)obj
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[obj copy]];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark 读出系统偏好
- (NSString *)readToNSDefaultsWithKey:(NSString *)key
{
   return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
