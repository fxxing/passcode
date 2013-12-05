//
//  AppContext.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "Option.h"

@interface AppContext : NSObject {
}

@property (nonatomic, strong) Option *option;
@property (nonatomic, strong) NSString *password;

SINGLETON_PROTOTYPE(AppContext)

- (void)load;
- (void)persist;

@end
