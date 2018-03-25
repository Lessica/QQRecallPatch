//
//  NSObject+QQMessageRecallModule.m
//  QQRecallPatchDylib
//
//  Created by Zheng on 24/03/2018.
//  Copyright © 2018 Zheng. All rights reserved.
//

#import "NSObject+QQMessageRecallModule.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>



@interface QQMessageRecallModule : NSObject
@end


@implementation NSObject (QQMessageRecallModule)

- (void)dev_handleRecallNotify:(struct RecallModel *)arg1 isOnline:(BOOL)arg2;
{
    RecallModel *recallModel = (RecallModel *)arg1;
    
    id enabledVal = [[NSUserDefaults standardUserDefaults] objectForKey:@"RecallPatchEnabled"];
    if (!enabledVal) {
        enabledVal = @(YES); // default value
    }
    
    if ([enabledVal boolValue]) {
        return;
    }
    
    [self dev_handleRecallNotify:recallModel isOnline:arg2];
}

@end
