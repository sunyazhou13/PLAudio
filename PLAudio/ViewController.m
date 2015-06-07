//
//  ViewController.m
//  AudioDemo
//
//  Created by coderyi on 15/5/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PLAudioPlayer.h"
#import "PLAudioRecorder.h"

@interface ViewController (){
    PLAudioRecorder *audioRecorder;
    PLAudioPlayer *audioPlayer;
    UILabel *label;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    audioRecorder = [[PLAudioRecorder alloc] init];
    
    /**
     *  是否需要转码的逻辑判断，默认为NO
     当为NO是录制的格式是默认的wav格式，这种格式iOS是支持的；
     因为iOS支持的格式基本android都不支持，android支持的iOS全部都不支持，但是为了实现与android平台的IM互通，所以把iOS支持的wav转为android支持的amr
     所以这里可以设置isNeedConvert为yes，表示在录制完成后会转换成amr格式
     */
    audioRecorder.isNeedConvert=YES;
    
    
    
    audioPlayer = [[PLAudioPlayer alloc] init];
    /**
     *  是否需要转码的逻辑判断，默认为NO
     当为NO是录制的格式是默认的wav格式，这种格式iOS是支持的；
     因为iOS支持的格式基本android都不支持，android支持的iOS全部都不支持，但是为了实现与android平台的IM互通，所以把iOS支持的wav转为android支持的amr
     所以这里可以设置isNeedConvert为yes，表示在播放之前，会把amr格式的转换为wav格式
     */
    audioPlayer.isNeedConvert=YES;
    
    
    label=[[UILabel alloc] initWithFrame:CGRectMake(200, 120, 100, 100)];
    label.backgroundColor=[UIColor whiteColor];
    label.textColor=[UIColor colorWithRed:0.26 green:0.52 blue:0.96 alpha:1];
    label.text=@"大";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    label.hidden=YES;
  
    
    UIButton *startRecordBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startRecordBt];
    startRecordBt.backgroundColor=[UIColor redColor];
    startRecordBt.frame=CGRectMake(50, 120, 100, 40);
    [startRecordBt setTitle:@"录音" forState:UIControlStateNormal];
    [startRecordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startRecordBt addTarget:self action:@selector(startRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *endRecordBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:endRecordBt];
    endRecordBt.backgroundColor=[UIColor redColor];
    endRecordBt.frame=CGRectMake(50, 165, 100, 40);
    [endRecordBt setTitle:@"结束录音" forState:UIControlStateNormal];
    [endRecordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endRecordBt addTarget:self action:@selector(endRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *startPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startPlayBt];
    startPlayBt.frame=CGRectMake(50, 210, 100, 40);
    [startPlayBt setTitle:@"播放" forState:UIControlStateNormal];
    [startPlayBt addTarget:self action:@selector(startPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    startPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [startPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    
    
    UIButton *endPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:endPlayBt];
    endPlayBt.frame=CGRectMake(50, 260, 100, 40);
    [endPlayBt setTitle:@"结束播放" forState:UIControlStateNormal];
    [endPlayBt addTarget:self action:@selector(endPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    endPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [endPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
 

     
}
-(void)startRecordBtAction{
    

    [audioRecorder startRecordWithFilePath:[PLAudioPath recordPathOrigin]
                                   updateMeters:^(float meters){
                                       [self updateVolumeUI:meters];

                                       
                                   }
                                        success:^(NSData *recordData){
                                            NSLog(@"录音成功");
                                             label.hidden=YES;

                                            
                                        }
                                         failed:^(NSError *error){
                                                  NSLog(@"录音失败");
                                              label.hidden=YES;

                                             
                                             
                                         }];
    
    

}


-(void)endRecordBtAction{
    [audioRecorder stopRecord];
    
}

-(void)startPlayBtAction{

    [audioPlayer startPlayAudioFile:[PLAudioPath recordPathOriginToAMR]
                       updateMeters:^(float meters){
                           [self updateVolumeUI:meters];
                           
                       }
                                 success:^{
                                     // 停止UI的播放
//
                                     NSLog(@"播放成功");
                                      label.hidden=YES;

                                    

                                 } failed:^(NSError *error) {
                                     // 停止UI的播放
                                      label.hidden=YES;

                                     NSLog(@"播放失败");
                                 } ];

    
    

    
    
}


-(void)endPlayBtAction{
    [audioPlayer stopPlay];
    
}


-(void)updateVolumeUI:(float )meters{
    
    float m = fabsf(meters);
    
    NSInteger iconNumber = 3;
    
    float scale = (60 - m )/60;
    
    if (scale <= 0.2f ){
        iconNumber = 1;
    } else if (scale > 0.2f && scale <= 0.4f) {
        iconNumber = 2;
    }else if (scale > 0.4f && scale <= 0.6f) {
        iconNumber = 3;
    }else if (scale > 0.6f && scale <= 0.8f) {
        iconNumber = 4;
    } else {
        iconNumber = 5;
    }
    label.hidden=NO;
    if (iconNumber==1) {
        label.font=[UIFont systemFontOfSize:10    ];
    }else if (iconNumber==2){
        
        label.font=[UIFont systemFontOfSize:15    ];
    }else if (iconNumber==3){
        label.font=[UIFont systemFontOfSize:25    ];
        
    }else if (iconNumber==4){
        label.font=[UIFont systemFontOfSize:45    ];
        
    }else if (iconNumber==5){
        label.font=[UIFont systemFontOfSize:85    ];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
