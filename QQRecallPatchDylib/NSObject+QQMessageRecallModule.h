//
//  NSObject+QQMessageRecallModule.h
//  QQRecallPatchDylib
//
//  Created by Zheng on 24/03/2018.
//  Copyright © 2018 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <vector>

@interface NSObject (QQMessageRecallModule)

@end

typedef union {
    unsigned long long _field1;
    unsigned long long _field2;
    unsigned long long _field3;
} XXUnion_znrfyA;

typedef struct RecallItem {
    bool _field1;
    unsigned long long _field2;
    XXUnion_znrfyA _field3;
    unsigned _field4;
    unsigned _field5;
    unsigned _field6;
    unsigned _field7;
    unsigned _field8;
    unsigned _field9;
} RecallItem;

typedef struct RecallModel {
    /*function-pointer*/ void** _field1;
    int _field2;
    bool _field3;
    std::vector<RecallItem *> _field4;
} RecallModel;

