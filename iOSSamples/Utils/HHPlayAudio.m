//
//  HHPlayAudio.m
//  testAutio
//
//  Created by guo qingming on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HHPlayAudio.h"

@implementation HHPlayAudio


+ (id)getShareInstance
{
    static HHPlayAudio *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[HHPlayAudio alloc] init];
    });
    
    return instance;
}

+(void)playSysAudio:(SystemSoundID)id
{
    AudioServicesPlaySystemSound(id);
}
+(void)playAudio:(NSString *)name
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],name];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    
    //TODO
    //AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}
@end
