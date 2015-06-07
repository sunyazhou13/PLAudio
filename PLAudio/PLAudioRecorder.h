//
//  PLAudioRecorder.h
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RecordFailed)(NSError *error);//录音失败的回调block
typedef void (^RecordSuccess)(NSData *recordData);//录音成功的回调block
typedef void (^RecordWithMeters)(float meters);//实时返回当前录音的平均功率

extern NSString * const RecordErrorStart;//开始录音的时候失败NSError的domain
extern NSString * const RecordErrorPermissionDenied;//用户禁用麦克风的NSError的domain

@interface PLAudioRecorder : NSObject
/**
 *  是否需要转码的逻辑判断，默认为NO
 当为NO是录制的格式是默认的wav格式，这种格式iOS是支持的；
 因为iOS支持的格式基本android都不支持，android支持的iOS全部都不支持，但是为了实现与android平台的IM互通，所以把iOS支持的wav转为android支持的amr
 所以这里可以设置isNeedConvert为yes，表示在录制完成后会转换成amr格式
 */
@property BOOL isNeedConvert;
- (void)startRecordWithFilePath:(NSString *)path
                   updateMeters:(RecordWithMeters)meters
                        success:(RecordSuccess)success
                         failed:(RecordFailed)failed;//开始录音
- (void)stopRecord;//结束录音
@end
