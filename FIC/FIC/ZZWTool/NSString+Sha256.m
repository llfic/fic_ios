//
//  NSString+Sha256.m
//  FIC
//
//  Created by fic on 2018/11/7.
//  Copyright © 2018年 fic. All rights reserved.
//

#import "NSString+Sha256.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Sha256)
- (NSString *)SHA256
{
//    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
//    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
//
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
//    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
//    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//    NSString *hash = [out description];
//    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
//    return hash;
    
    
    NSData *dataIn = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(dataIn.bytes, (CC_LONG)dataIn.length,  macOut.mutableBytes);
    NSString *hash = [macOut description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
    
}

@end
