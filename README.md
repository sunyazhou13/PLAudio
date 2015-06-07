# PLAudio
iOS和Android音频互通，提供音频的录制与播放，音频格式AMR和WAV互转（支持64位）。
音频转码的实现的是使用libopencore框架，这里引用了[Jeans](http://my.oschina.net/jeans)对libopencore的封装。

######PLAudioPlayer类的使用

PLAudioPlayer类是音频播放的类，首先需要初始化，初始化时，如果需要把iOS不支持的格式AMR转为iOS支持的格式WAV，则设为YES，否则就默认播放iOS支持的格式。

	audioRecorder = [[PLAudioRecorder alloc] init];

 	audioRecorder.isNeedConvert=YES;
    
PLAudioPlayer类提供播放音频和停止播放的方法，

    // 播放音频
	
    - (void)startPlayAudioFile:(NSString *)fileName
	updateMeters:(AudioPlayerWithMeters)meters
                   success:(AudioPlayerSuccess)success
                    failed:(AudioPlayerFailed)failed ;

	// 停止播放
	- (void)stopPlay;



startPlayAudioFile使用如下

 
    [audioPlayer startPlayAudioFile:[PLAudioPath recordPathOriginToAMR]
                       updateMeters:^(float meters){
                           //实时返回播放时声音的平均功率
                       }
                                 success:^{
                                     // 播放成功
                                 } failed:^(NSError *error) {
                                     // 播放失败
                                 } ];


                                         
   
   
   
######PLAudioPlayer类的使用

PLAudioPlayer类是音频录制的类，首先需要初始化，初始化时，如果需要在iOS录制WAV文件完成后转换为Android支持的AMR格式，则设为YES，否则就默认在录制为WAV格式，不进行转码工作。

    audioPlayer = [[PLAudioPlayer alloc] init];
 
    audioPlayer.isNeedConvert=YES;
    
PLAudioPlayer类提供开始录音和结束录音的方法，

    - (void)startRecordWithFilePath:(NSString *)path
                   updateMeters:(RecordWithMeters)meters
                        success:(RecordSuccess)success
                         failed:(RecordFailed)failed;//开始录音
    - (void)stopRecord;//结束录音



startRecordWithFilePath使用如下

    [audioRecorder startRecordWithFilePath:[PLAudioPath recordPathOrigin]
                                   updateMeters:^(float meters){
                                       //实时返回录制时声音的平均功率
                                   }
                                        success:^(NSData *recordData){
                                            //录音成功
                                        }
                                         failed:^(NSError *error){
                                                  //录音失败
                                         }];
                                        
                                        


最后，这里使用了Jeans封装的libopencore的AMR和WAV互转的库，他的库的地址在，[http://www.oschina.net/code/snippet_562429_12400](http://www.oschina.net/code/snippet_562429_12400)也非常感谢他！

PLAudio的前缀PL的全称是PeakLight，PeakLight是中文“峰亮”的翻译，PLAudio的建立日期是2015年6月8日，也是为了纪念2011年6月8日。

                                         
                                         
            
                                         
                                         
    

