//
//  PLAudioPath.m
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PLAudioPath.h"
#import <sys/xattr.h>
@implementation PLAudioPath
+ (NSString *)recordPathOrigin{
    NSString * filePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *str1 = NSHomeDirectory();
    filePath = [NSString stringWithFormat:@"%@/Documents/RecordTest/recordTest.wav",str1];
    
    if(![fileManager fileExistsAtPath:filePath]){
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *directryPath = [path stringByAppendingPathComponent:@"RecordTest"];
        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [directryPath stringByAppendingPathComponent:@"recordTest.wav"];
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    [self skipICloud:filePath];
    
    return filePath;
}


+ (NSString *)recordPathOriginToAMR{
    NSString * filePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *str1 = NSHomeDirectory();
    filePath = [NSString stringWithFormat:@"%@/Documents/RecordTest/recordTest.amr",str1];
    
    if(![fileManager fileExistsAtPath:filePath]){
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *directryPath = [path stringByAppendingPathComponent:@"RecordTest"];
        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [directryPath stringByAppendingPathComponent:@"recordTest.amr"];
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    [self skipICloud:filePath];
    
    return filePath;
}


+ (NSString *)recordPathAMRToWAV{
    NSString * filePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *str1 = NSHomeDirectory();
    filePath = [NSString stringWithFormat:@"%@/Documents/RecordTest/recordTest.wav",str1];
    
    if(![fileManager fileExistsAtPath:filePath]){
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *directryPath = [path stringByAppendingPathComponent:@"RecordTest"];
        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [directryPath stringByAppendingPathComponent:@"recordTest.wav"];
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    [self skipICloud:filePath];
    
    return filePath;
}

/**
 *
 For more information, please see https://developer.apple.com/library/ios/#qa/qa1719/_index.html
 - Install and launch your app
 - Go to Settings > iCloud > Storage & Backup > Manage Storage
 - If necessary, tap "Show all apps"
 - Check your app's storage
 
 *
 *  @return 需要忽略iCloud备份的路径
 */
+ (void)skipICloud:(NSString*)url{
    u_int8_t b = 1;
    if (nil == url ) {
        return;
    }
    setxattr([url fileSystemRepresentation], "com.apple.MobileBackup", &b, 1, 0, 0);
}


@end
