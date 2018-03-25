//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  QQRecallPatchDylib.m
//  QQRecallPatchDylib
//
//  Created by Zheng on 23/03/2018.
//  Copyright (c) 2018 Zheng. All rights reserved.
//

#import "QQRecallPatchDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>

#import "NSObject+JRSwizzle.h"

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);
#endif
        
    }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
CHConstructor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class recallClass = objc_getClass("QQMessageRecallModule");
        [recallClass jr_swizzleMethod:@selector(handleRecallNotify:isOnline:) withMethod:@selector(dev_handleRecallNotify:isOnline:) error:nil];
    });
}
#pragma clang diagnostic pop

