//
//  UIViewController+Test.m
//  TestDemo
//
//  Created by vane on 2019/8/9.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "UIViewController+Test.h"

@implementation UIViewController (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        swizzleMethodTest(class, @selector(viewDidLoad), @selector(test_viewDidLoad));
    });
}

void swizzleMethodTest(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)test_viewDidLoad {
//    NSLog(@"viewcontroller-----swizzlingTest");

    [self test_viewDidLoad];
}

@end
