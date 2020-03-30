//
//  Definition.h
//  TestDemo
//
//  Created by vane on 20/06/2018.
//  Copyright © 2018 vane.greenisland. All rights reserved.
//

#ifndef Definition_h
#define Definition_h

#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

//SystemDevice
#define kScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight       ([[UIScreen mainScreen] bounds].size.height)

#endif /* Definition_h */
