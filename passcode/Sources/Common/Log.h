//
//  Log.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//

#define LOG_FLAG_DEBUG                      LOG_FLAG_VERBOSE
#define LOG_LEVEL_DEBUG                     LOG_LEVEL_VERBOSE
#define LOG_ASYNC_DEBUG                     LOG_ASYNC_VERBOSE

#define DDLogPCError(frmt, ...)            LOG_OBJC_MAYBE(LOG_ASYNC_ERROR,   pcLogLevel, LOG_FLAG_ERROR,   0, frmt, ##__VA_ARGS__)
#define DDLogPCWarn(frmt, ...)             LOG_OBJC_MAYBE(LOG_ASYNC_WARN,    pcLogLevel, LOG_FLAG_WARN,    0, frmt, ##__VA_ARGS__)
#define DDLogPCInfo(frmt, ...)             LOG_OBJC_MAYBE(LOG_ASYNC_INFO,    pcLogLevel, LOG_FLAG_INFO,    0, frmt, ##__VA_ARGS__)
#define DDLogPCDebug(frmt, ...)            LOG_OBJC_MAYBE(LOG_ASYNC_DEBUG,   pcLogLevel, LOG_FLAG_DEBUG,   0, frmt, ##__VA_ARGS__)
