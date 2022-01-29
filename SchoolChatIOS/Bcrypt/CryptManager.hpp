//
//  CryptManager.hpp
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.01.2022.
//

#ifndef CryptManager_hpp
#define CryptManager_hpp

#include <stdio.h>
#include <string>

class CryptManager {
public:
    std::string HashPassword(std::string password);
};

#endif /* CryptManager_hpp */
