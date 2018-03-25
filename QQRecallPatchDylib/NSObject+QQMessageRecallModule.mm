//
//  NSObject+QQMessageRecallModule.m
//  QQRecallPatchDylib
//
//  Created by Zheng on 24/03/2018.
//  Copyright © 2018 Zheng. All rights reserved.
//

#import "NSObject+QQMessageRecallModule.h"
#import "UIView+XXTEToast.h"
#import <objc/runtime.h>


@interface QQMessageModel : NSObject

@end

@interface RecallC2CBaseProcessor : NSObject
- (id)convertRecallItemToMsg:(struct RecallItem *)arg1 recallModel:(struct RecallModel *)arg2 msgType:(int)arg3;
@end

@interface RecallGroupBaseProcessor : NSObject
- (QQMessageModel *)convertRecallItemToMsg:(struct RecallItem *)arg1 recallModel:(struct RecallModel *)arg2 msgType:(int)arg3 isOnline:(_Bool)arg4;
@end

@interface RecallPairForOffline : NSObject
@property (strong, nonatomic) NSArray *msgs;
@property (nonatomic) int orignalMsgType;
@property (nonatomic) struct RecallModel *recallModel;
@end

@interface QQMessageRecallModule : NSObject
- (void)notifyAIOUpdate:(id)arg1;
- (void)notifyMsgListUpdate:(id)arg1 recallModel:(struct RecallModel *)arg2;
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
        RecallItem *recallItem = arg1->_field4.at(0);
        int recallType = recallModel->_field2;
        
        NSMutableArray *msgs = [[NSMutableArray alloc] initWithCapacity:1];
        if (recallType == 0) { // c2c
            id processor = [objc_getClass("RecallC2CBaseProcessor") new];
            QQMessageModel *messageModel = [processor convertRecallItemToMsg:recallItem recallModel:recallModel msgType:0];
            if (messageModel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                if ([objc_getClass("QQPlatform") respondsToSelector:@selector(sharedPlatform)]) {
                    id sharedPlatform = [objc_getClass("QQPlatform") performSelector:@selector(sharedPlatform)];
                    if ([sharedPlatform respondsToSelector:@selector(QQServiceCenter)]) {
                        id serviceCenter = [sharedPlatform performSelector:@selector(QQServiceCenter)];
                        if ([serviceCenter respondsToSelector:@selector(C2CMultiTableDB)]) {
                            id c2cDb = [serviceCenter performSelector:@selector(C2CMultiTableDB)];
                            if ([c2cDb respondsToSelector:@selector(batchInsertReceivedMessages:)]) {
                                [c2cDb performSelector:@selector(batchInsertReceivedMessages:) withObject:@[messageModel]];
                            }
                        }
                    }
                }
#pragma clang diagnostic pop
                [msgs addObject:messageModel];
            }
        } else if (recallType == 1) { // group
            id processor = [objc_getClass("RecallGroupBaseProcessor") new];
            QQMessageModel *messageModel = [processor convertRecallItemToMsg:recallItem recallModel:recallModel msgType:0 isOnline:arg2];
            
        }
        
        if (arg2) {
            // notify AIO and msg list
            id recallPair = [objc_getClass("RecallPairForOffline") new];
            [recallPair setMsgs:[msgs copy]];
            [recallPair setRecallModel:recallModel];
            [recallPair setOrignalMsgType:0];
            id selfRef = self;
            [selfRef notifyAIOUpdate:recallPair];
            [selfRef notifyMsgListUpdate:[msgs copy] recallModel:recallModel];
        }
        
        return;
    }
    
    [self dev_handleRecallNotify:recallModel isOnline:arg2];
}

@end
