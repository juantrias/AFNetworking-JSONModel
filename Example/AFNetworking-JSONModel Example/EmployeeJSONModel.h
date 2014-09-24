//
//  EmployeeJSONModel.h
//  AFNetworking-JSONModel Example
//
//  Created by Juan on 24/09/14.
//  Copyright (c) 2014 IGZ. All rights reserved.
//

#import "JSONModel.h"
#import "DepartmentJSONModel.h"

@protocol EmployeeJSONModel
@end

@interface EmployeeJSONModel : JSONModel

@property (strong, atomic) NSNumber *id;
@property (strong, atomic) NSString *name;
@property (strong, atomic) DepartmentJSONModel<Optional> *department;

@end
