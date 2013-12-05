//
//  FileUtils.h
//  passcode
//
//  Created by Fengxiang Xing on 9/27/13.
//  Copyright (c) 2013 Fengxiang Xing. All rights reserved.
//


NSString *read_file(NSString *name, BOOL encrypt);

void write_file(NSString *name, NSString *content, BOOL encrypt);