//
//  NSObject+JRSwizzle.h
//  QQRecallPatchDylib
//
//  Created by Zheng on 24/03/2018.
//  Copyright © 2018 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JRSwizzle)

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;

@end
