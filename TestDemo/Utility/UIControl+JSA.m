//
//  UIControl+JSA.m
//  TestDemo
//
//  Created by vane on 24/08/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#import "UIControl+JSA.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIcontrol_ignoreEvent";

@implementation UIControl (JSA)

- (NSTimeInterval)jsa_acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setJsa_acceptEventInterval:(NSTimeInterval)jsa_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(jsa_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)jsa_ignoreEvent {
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

- (void)setJsa_ignoreEvent:(BOOL)jsa_ignoreEvent {
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(jsa_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)_jsa_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.jsa_ignoreEvent) {
        return;
    }
    
    if (self.jsa_acceptEventInterval > 0) {
        self.jsa_ignoreEvent = YES;
        
        [self performSelector:@selector(setJsa_ignoreEvent:) withObject:@(NO) afterDelay:self.jsa_acceptEventInterval];
    }
    
    [self _jsa_sendAction:action to:target forEvent:event];
}

+ (void)load {
    
    // 不启用
    
//    Method a = class_getClassMethod(self, @selector(sendAction:to:forEvent:));
//    Method b = class_getClassMethod(self, @selector(_jsa_sendAction:to:forEvent:));
//    
//    method_exchangeImplementations(a, b);
}

@end
