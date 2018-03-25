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

@interface QQMessageModel : NSObject
@end

@interface QQMessageRecallModule : NSObject
@end

@interface RecallC2CBaseProcessor : NSObject
- (id)convertRecallItemToMsg:(struct RecallItem *)arg1 recallModel:(struct RecallModel *)arg2 msgType:(int)arg3;
@end

@interface RecallGroupProcessor : NSObject
- (id)convertRecallItemToMsg:(struct RecallItem *)arg1 recallModel:(struct RecallModel *)arg2 msgType:(int)arg3 isOnline:(_Bool)arg4;
@end

@interface RecallDiscussProcessor : NSObject
- (id)convertRecallItemToMsg:(struct RecallItem *)arg1 recallModel:(struct RecallModel *)arg2 msgType:(int)arg3 isOnline:(_Bool)arg4;
@end

@interface QQToastView : UIView
+ (void)showTips:(id)arg1 atRootView:(id)arg2;
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
        
        id toastEnabledVal = [[NSUserDefaults standardUserDefaults] objectForKey:@"RecallToastEnabled"];
        if (!toastEnabledVal) {
            toastEnabledVal = @(NO); // default value
        }
        
        if ([toastEnabledVal boolValue]) {
            
            RecallItem *recallItem = arg1->_field4.at(0);
            int recallType = recallModel->_field2;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if (recallType == 0) { // c2c
                dispatch_async(dispatch_get_main_queue(), ^{
                    id processor = [objc_getClass("RecallC2CBaseProcessor") new];
                    QQMessageModel *messageModel = [processor convertRecallItemToMsg:recallItem recallModel:recallModel msgType:0x14c];
                    if ([messageModel respondsToSelector:@selector(content)]) {
                        [objc_getClass("QQToastView") showTips:[messageModel performSelector:@selector(content)] atRootView:[[UIApplication sharedApplication] keyWindow]];
                    }
                });
            } else if (recallType == 1) { // group
                dispatch_async(dispatch_get_main_queue(), ^{
                    id processor = [objc_getClass("RecallGroupProcessor") new];
                    QQMessageModel *messageModel = [processor convertRecallItemToMsg:recallItem recallModel:recallModel msgType:0x14c isOnline:arg2];
                    if ([messageModel respondsToSelector:@selector(content)]) {
                        [objc_getClass("QQToastView") showTips:[messageModel performSelector:@selector(content)] atRootView:[[UIApplication sharedApplication] keyWindow]];
                    }
                });
            } else if (recallType == 2) { // discuss
                dispatch_async(dispatch_get_main_queue(), ^{
                    id processor = [objc_getClass("RecallDiscussProcessor") new];
                    QQMessageModel *messageModel = [processor convertRecallItemToMsg:recallItem recallModel:recallModel msgType:0x14c isOnline:arg2];
                    if ([messageModel respondsToSelector:@selector(content)]) {
                        [objc_getClass("QQToastView") showTips:[messageModel performSelector:@selector(content)] atRootView:[[UIApplication sharedApplication] keyWindow]];
                    }
                });
            }
#pragma clang diagnostic pop
            
            if (arg2) {
                // notify AIO and msg list
                
            }
            
        }
        
        return;
    }
    
    [self dev_handleRecallNotify:recallModel isOnline:arg2];
}

- (NSString *)c2c_getRecallMessageContent:(struct RecallItem *)arg1 {
    RecallItem *recallModel = (RecallItem *)arg1;
    [self c2c_getRecallMessageContent:recallModel];
    return @"对方尝试撤回一条消息 (已阻止)";
}

- (NSString *)grp_getRecallMessageContent:(struct RecallModel *)arg1 item:(struct RecallItem *)arg2 msg:(id)arg3 isOnline:(_Bool)arg4 {
    RecallModel *recallModel = (RecallModel *)arg1;
    RecallItem *recallItem = (RecallItem *)arg2;
    id recallMsg = arg3;
    NSString *originalContent = [self grp_getRecallMessageContent:recallModel item:recallItem msg:recallMsg isOnline:arg4];
    NSMutableString *replacedContent = [[NSMutableString alloc] initWithString:originalContent];
    [replacedContent replaceOccurrencesOfString:@"撤回了一条消息" withString:@"尝试撤回一条消息 (已阻止)"
                                        options:0 range:NSMakeRange(0, originalContent.length)];
    return [replacedContent copy];
}

- (NSString *)dis_getRecallMessageContent:(struct RecallModel *)arg1 item:(struct RecallItem *)arg2 msg:(id)arg3 isOnline:(_Bool)arg4 {
    RecallModel *recallModel = (RecallModel *)arg1;
    RecallItem *recallItem = (RecallItem *)arg2;
    id recallMsg = arg3;
    NSString *originalContent = [self dis_getRecallMessageContent:recallModel item:recallItem msg:recallMsg isOnline:arg4];
    NSMutableString *replacedContent = [[NSMutableString alloc] initWithString:originalContent];
    [replacedContent replaceOccurrencesOfString:@"撤回了一条消息" withString:@"尝试撤回一条消息 (已阻止)"
                                        options:0 range:NSMakeRange(0, originalContent.length)];
    return [replacedContent copy];
}

@end
