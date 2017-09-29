// ......

#include "protobuf/pbc-lua.h"

// ......

bool AppDelegate::applicationDidFinishLaunching()
{
    // ......

    register_all_packages();

    luaopen_protobuf_c(L); // 注册pbc

    LuaStack* stack = engine->getLuaStack();
   // ......
}

// ......