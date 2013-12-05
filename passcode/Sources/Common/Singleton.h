//
//  Singleton.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#define SINGLETON_PROTOTYPE(CLASSNAME) \
+ (CLASSNAME*)instance;

#define SINGLETON_IMPLEMENT(CLASSNAME) \
+ (CLASSNAME*)instance { \
    static CLASSNAME *_##CLASSNAME##_instance = nil;\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{\
        _##CLASSNAME##_instance = [[CLASSNAME alloc] init];\
    });\
    return _##CLASSNAME##_instance;\
}