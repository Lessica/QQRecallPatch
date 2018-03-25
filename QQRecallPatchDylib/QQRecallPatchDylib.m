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
#import "NSObject+JRSwizzle.h"


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

