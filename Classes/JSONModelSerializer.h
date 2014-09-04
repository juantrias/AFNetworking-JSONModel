//
//  JSONModelSerializer.h
//  KAI01
//
//  Created by Juan on 24/04/14.
//  Copyright (c) 2014 Intelygenz. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JSONModelSerializer : AFHTTPResponseSerializer

+ (instancetype)serializerForClass:(Class) clazz;

@end
