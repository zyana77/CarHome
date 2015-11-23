//
//  ParameterController.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/21.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"

typedef void (^parameterBlock)();

@interface ParameterController : UIViewController

@property (nonatomic, strong) BrandModel *brandModel;
@property (nonatomic, copy) parameterBlock parameterBlock;

@end
