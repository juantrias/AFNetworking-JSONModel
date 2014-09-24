//
//  ViewController.m
//  AFNetworking-JSONModel Example
//
//  Created by Juan on 24/09/14.
//  Copyright (c) 2014 IGZ. All rights reserved.
//

#import "ViewController.h"
#import "EmployeeJSONModel.h"
#import <AFNetworking-JSONModel/AFHTTPRequestOperationManager+JsonModelRequestOperationManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *baseUrl = [NSURL URLWithString:@"http://private-591db-afnetworkingjsonmodelapi.apiary-mock.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    
    [manager GET:@"/employees/1" parameters:nil clazz:[EmployeeJSONModel class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        EmployeeJSONModel *employee = (EmployeeJSONModel *)responseObject;
        
        NSLog(@"Success: %@", employee);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
