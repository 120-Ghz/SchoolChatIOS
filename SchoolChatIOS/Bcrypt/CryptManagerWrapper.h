#import <Foundation/Foundation.h>

@interface CryptManagerWrapper : NSObject

- (NSString *) HashPassword : (NSString*) password;
- (BOOL) ComparePassword : (NSString*) hash : (NSString*) UserInput;

@end
