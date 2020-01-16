//
//  AFSessionUtil+HomeRequest.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/4.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "AFSessionUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFSessionUtil (HomeRequest)

+ (void)home_requestWithTitle:(NSString *)title response:(ResponseObj)response;

@end

NS_ASSUME_NONNULL_END
