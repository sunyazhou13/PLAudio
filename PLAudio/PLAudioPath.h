//
//  PLAudioPath.h
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLAudioPath : NSObject
+ (NSString *)recordPathOrigin;  
+ (NSString *)recordPathOriginToAMR;
+ (NSString *)recordPathAMRToWAV;
@end
