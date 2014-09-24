//
//  DepartmentJSONModel.h
//  AFNetworking-JSONModel Example
//
//  Created by Juan on 24/09/14.
//  Copyright (c) 2014 IGZ. All rights reserved.
//

#import "JSONModel.h"

@protocol EmployeeJSONModel;

@interface DepartmentJSONModel : JSONModel

@property (strong, atomic) NSString *name;
@property (strong, atomic) NSArray<EmployeeJSONModel> *employees;

@end
