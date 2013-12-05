//
//  EncryptUtils.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//


NSString *encrypt_aes(NSString *text);

NSString *decrypt_aes(NSString *text);

NSString *data2hex(NSData *data);

NSData *hex2data(NSString *hex);

NSString *hmac(NSString *text, NSString *key);