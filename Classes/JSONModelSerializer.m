//
//  JSONModelSerializer.m
//  KAI01
//
//  Created by Juan on 24/04/14.
//  Copyright (c) 2014 Intelygenz. All rights reserved.
//

#import "JSONModelSerializer.h"
#import <JSONModel/JSONModel.h>

@interface JSONModelSerializer ()

@property (strong, nonatomic) Class clazz;

@end

@implementation JSONModelSerializer

+ (instancetype)serializerForClass:(Class) clazz {
    
    if (![clazz isSubclassOfClass:[JSONModel class]]) {
        NSLog(@"ERROR: You must pass as a parameter a class that inherits from JSONModel. You passed %@", clazz);
        return nil;
    }
    
    JSONModelSerializer *serializer = [[self alloc] init];
    serializer.clazz = clazz;
    
    return serializer;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    
    NSData *validatedData = [super responseObjectForResponse:response data:data error:error];
    if (*error) {
        NSLog(@"%@", *error);
        return validatedData;
    }
    
    JSONModel *jsonModel = [[self.clazz alloc] initWithData:validatedData error:error];
    if (*error) {
        NSLog(@"%@", *error);
        return validatedData;
    }
    
    return jsonModel;
}

@end
