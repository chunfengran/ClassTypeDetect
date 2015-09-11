//
//  RFDBHelper.h
//  TypeDetect
//
//  Created by wangdazhitech on 9/11/15.
//  Copyright (c) 2015 wangdazhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFDBHelper : NSObject
+(NSArray *)modelGetClassPropertyList:(id) oneModel;
+(NSArray *)classGetPropertyList:(Class) oneClass;
@end
