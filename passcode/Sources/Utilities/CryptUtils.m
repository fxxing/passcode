//
//  EncryptUtils.m
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#import "CryptUtils.h"
#import "IPAddress.h"

static NSString *_aesKey;

void init_key();

NSData *_crypt_aes(NSData *data, NSString *key, CCOperation op);

NSString *encrypt_aes(NSString *text) {
    init_key();
    return data2hex(_crypt_aes([text dataUsingEncoding:NSUTF8StringEncoding], _aesKey, kCCEncrypt));
}

NSString *decrypt_aes(NSString *text) {
    init_key();
    return [[NSString alloc] initWithData:_crypt_aes(hex2data(text), _aesKey, kCCDecrypt) encoding:NSUTF8StringEncoding];
}

NSData *_crypt_aes(NSData *data, NSString *key, CCOperation op) {
    char aesKey[kCCKeySizeAES256 + 1];
    bzero(aesKey, sizeof(aesKey));
    [key getCString:aesKey maxLength:sizeof(aesKey) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    size_t bytesCrypted = 0;
    uint8_t *buffer = malloc(bufferSize);
    CCCryptorStatus cryptStatus = CCCrypt(op, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
            aesKey, kCCKeySizeAES128, NULL, [data bytes], dataLength,
            buffer, bufferSize, &bytesCrypted);
    NSData *cryptData = nil;
    if (cryptStatus == kCCSuccess) {
        cryptData = [NSData dataWithBytes:buffer length:bytesCrypted];
    }
    free(buffer);
    return cryptData;
}


NSString *data2hex(NSData *data) {
    uint8_t *dataBuffer = (uint8_t *) [data bytes];

    if (!dataBuffer)
        return [NSString string];

    NSUInteger dataLength = [data length];
    NSMutableString *hex = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
        [hex appendString:[NSString stringWithFormat:@"%02x", dataBuffer[i]]];
    }

    return [NSString stringWithString:hex];
}

NSData *hex2data(NSString *hex) {
    NSMutableData *data = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0', '\0', '\0'};
    int i;
    for (i = 0; i < [hex length] / 2; i++) {
        byte_chars[0] = [hex characterAtIndex:i * 2];
        byte_chars[1] = [hex characterAtIndex:i * 2 + 1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

NSString *hmac(NSString *text, NSString *key) {
    CCHmacContext ctx;
    const char *hmacKey = [key UTF8String];
    const char *str = [text UTF8String];
    unsigned char mac[CC_MD5_DIGEST_LENGTH];
    char hexMac[2 * CC_MD5_DIGEST_LENGTH + 1];
    char *p;

    CCHmacInit(&ctx, kCCHmacAlgMD5, hmacKey, strlen(hmacKey));
    CCHmacUpdate(&ctx, str, strlen(str));
    CCHmacFinal(&ctx, mac);

    p = hexMac;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf( p, 3, "%02x", mac[i] );
        p += 2;
    }

    return [NSString stringWithUTF8String:hexMac];
}

void init_key() {
    if (!_aesKey) {
        NSString *mac = [GetMacAddress() stringByReplacingOccurrencesOfString:@":" withString:@""];
        _aesKey = hmac(AES_KEY, mac);
    }
}