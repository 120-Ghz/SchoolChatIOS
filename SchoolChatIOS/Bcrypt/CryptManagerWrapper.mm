//
//  CryptManagerWrapper.m
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.01.2022.
//

#import <Foundation/Foundation.h>
#import "CryptManagerWrapper.h"
#import "CryptManager.hpp"

@implementation CryptManagerWrapper

- (NSString *) HashPassword : (NSString*) password {
    CryptManager cryptmanager;
    std::string pass = [password cStringUsingEncoding: [NSString defaultCStringEncoding]];
    std::string hashed_password = cryptmanager.HashPassword(pass);
    return [NSString stringWithCString:hashed_password.c_str() encoding:NSUTF8StringEncoding];
}
    
- (BOOL)ComparePassword : (NSString*)hash : (NSString*)UserInput {
    CryptManager cm;
    std::string UInput = [UserInput cStringUsingEncoding:[NSString defaultCStringEncoding]];
    std::string hashh = [hash cStringUsingEncoding:[NSString defaultCStringEncoding]];
    return cm.ComparePassword(hashh, UInput);
}

@end
