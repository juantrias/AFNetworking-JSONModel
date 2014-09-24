//
//  ViewController.m
//  AFNetworking-JSONModel Example
//
//  Created by Juan on 24/09/14.
//  Copyright (c) 2014 IGZ. All rights reserved.
//

#import "ViewController.h"
#import "EmployeeCell.h"
#import "EmployeeJSONModel.h"
#import <AFNetworking-JSONModel/AFHTTPRequestOperationManager+JsonModelRequestOperationManager.h>

@interface ViewController ()

@property (strong, nonatomic) EmployeeJSONModel *employee;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UITableView *departmentEmployeesTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self displayEmployee];
    
    NSURL *baseUrl = [NSURL URLWithString:@"http://private-591db-afnetworkingjsonmodelapi.apiary-mock.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    
    [manager GET:@"/employees/1" parameters:nil clazz:[EmployeeJSONModel class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.employee = (EmployeeJSONModel *)responseObject;
        NSLog(@"Success: %@", self.employee);
        
        [self displayEmployee];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)displayEmployee {
    
    if (self.employee == nil) {
        self.nameLabel.text = @"";
        self.departmentLabel.text = @"";
        return;
    }
    
    self.nameLabel.text = self.employee.name;
    if (self.employee.department != nil) {
        self.departmentLabel.text = self.employee.department.name;
        [self.departmentEmployeesTableView reloadData];
    }
    
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.employee != nil) {
        return self.employee.department.employees.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell"];
    
    if (self.employee != nil && self.employee.department != nil) {
        EmployeeJSONModel *departmentEmployee = self.employee.department.employees[indexPath.row];
        cell.nameLabel.text = departmentEmployee.name;
    }
    
    return cell;
}

@end
