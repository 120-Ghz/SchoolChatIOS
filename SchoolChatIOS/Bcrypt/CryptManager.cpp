//
//  CryptManager.cpp
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.01.2022.
//

#include "CryptManager.hpp"
#include "BCrypt.hpp"
std::string CryptManager::HashPassword(std::string password) {
    std:: string hash = BCrypt::generateHash(password);
    return hash;
}
