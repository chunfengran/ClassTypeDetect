//
//  RFDBHelper.m
//  TypeDetect
//
//  Created by wangdazhitech on 9/11/15.
//  Copyright (c) 2015 wangdazhi. All rights reserved.
//

#import "RFDBHelper.h"
#import <objc/runtime.h>

#define NS_TYPE_UNKNOWN @"UNKNOWN"
#define NS_TYPE_OBJECT @"NSObject"
#define NS_TYPE_NSNUMBER @"NSNumber"
#define NS_TYPE_NSSTRING @"NSString"
#define NS_TYPE_NSDICTIONARY @"NSDictionary"
#define NS_TYPE_NSDATE @"NSDate"
#define NS_TYPE_NSArray @"NSArray"
#define NS_TYPE_float @"float"

@implementation RFDBHelper

+(NSArray *)classGetPropertyList:(Class) oneClass{
	NSMutableArray *propertyNamesArray = [NSMutableArray array];
	unsigned int propertyCount = 0;
	objc_property_t *properties = class_copyPropertyList(oneClass, &propertyCount);
	for (unsigned int i = 0; i < propertyCount; ++i) {
		objc_property_t property = properties[i];
		const char *	name = property_getName(properties[i]);
		const char *	attr = property_getAttributes(properties[i]);
		
		NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
		NSString *		propertyType = [RFDBHelper typeOf:attr];
		
		
		NSLog(@"%s",property_getAttributes(property));
		NSDictionary * oneDic=[NSDictionary dictionaryWithObjectsAndKeys:propertyName,@"name",propertyType,@"type", nil];
		[propertyNamesArray addObject:oneDic];
	}
	free(properties);
	return propertyNamesArray;
}

+ (NSString *)typeOf:(const char *)attr
{
	if ( attr[0] != 'T' )
		return  NS_TYPE_UNKNOWN;
	
	const char * type = &attr[1];
	if ( type[0] == '@' )
	{
		if ( type[1] != '"' )
			return NS_TYPE_UNKNOWN;
		
		char typeClazz[128] = { 0 };
		
		const char * clazz = &type[2];
		const char * clazzEnd = strchr( clazz, '"' );
		
		if ( clazzEnd && clazz != clazzEnd )
		{
			unsigned int size = (unsigned int)(clazzEnd - clazz);
			strncpy( &typeClazz[0], clazz, size );
		}
		
		if ( 0 == strcmp((const char *)typeClazz, "NSNumber") )
		{
			return NS_TYPE_NSNUMBER;
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSString") )
		{
			return NS_TYPE_NSSTRING;
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSDate") )
		{
			return NS_TYPE_NSDATE;
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSArray") )
		{
			return NS_TYPE_NSArray;
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSDictionary") )
		{
			return NS_TYPE_NSDICTIONARY;
		}
		else
		{
			return NS_TYPE_OBJECT;
		}
	}
	else if ( type[0] == '[' )
	{
		return NS_TYPE_UNKNOWN;
	}
	else if ( type[0] == '{' )
	{
		return NS_TYPE_UNKNOWN;
	}
	else
	{
		if ( type[0] == 'c' || type[0] == 'C' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == 'i' )
		{
			return @"int";
		}
		else if ( type[0] == 's' || type[0] == 'l' || type[0] == 'q' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == 'I' || type[0] == 'S' || type[0] == 'L' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if(type[0] == 'Q' )
		{
		
			return @"long";
		}
		else if ( type[0] == 'f' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == 'd' )
		{
			return NS_TYPE_float;
		}
		else if ( type[0] == 'B' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == 'v' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == '*' )
		{
			return @"char";
		}
		else if ( type[0] == ':' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( 0 == strcmp(type, "bnum") )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == '^' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else if ( type[0] == '?' )
		{
			return NS_TYPE_UNKNOWN;
		}
		else
		{
			return NS_TYPE_UNKNOWN;
		}
	}
	
	return NS_TYPE_UNKNOWN;
}

@end
