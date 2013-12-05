//
//  FileUtils.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import "FileUtils.h"
#import "CryptUtils.h"
#import "IPAddress.h"

NSString *get_file_path(NSString *name);

NSString *read_file(NSString *name, BOOL encrypt) {
    NSString *path = get_file_path(name);
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (content && encrypt) {
        content = decrypt_aes(content);
    }
    return content;
}

void write_file(NSString *name, NSString *content, BOOL encrypt) {\
    if (encrypt) {
        content = encrypt_aes(content);
    }

    NSString *path = get_file_path(name);
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


NSString *get_file_path(NSString *name) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
}



