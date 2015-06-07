//
//  PLAudioPlayer.h
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^AudioPlayerFailed)(NSError *error);
typedef void (^AudioPlayerSuccess)();
typedef void (^AudioPlayerWithMeters)(float meters);//实时返回当前音频的平均功率
@interface PLAudioPlayer : NSObject<AVAudioPlayerDelegate>

/**
 *  是否需要转码的逻辑判断，默认为NO
 当为NO是录制的格式是默认的wav格式，这种格式iOS是支持的；
 因为iOS支持的格式基本android都不支持，android支持的iOS全部都不支持，但是为了实现与android平台的IM互通，所以把iOS支持的wav转为android支持的amr
 所以这里可以设置isNeedConvert为yes，表示在播放之前，会把amr格式的转换为wav格式
 */
@property BOOL isNeedConvert;



//是否正在播放音频
- (BOOL)isPlaying;

// 播放音频
- (void)startPlayAudioFile:(NSString *)fileName
updateMeters:(AudioPlayerWithMeters)meters
                   success:(AudioPlayerSuccess)success
                    failed:(AudioPlayerFailed)failed ;

// 停止播放
- (void)stopPlay;







@end
