//
//  Utility.m
//  DAContextMenuTableViewControllerDemo
//
//  Created by Tianyu Shi on 11/17/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(id) initWithStringfirstName: (NSString*) firstName lastName:(NSString*)lastName company:(NSString*) company tags:(NSString*) tags notes:(NSString*) notes status:(NSString*) status picUrl:(NSString*) picUrl email:(NSString*) email phoneNumber:(NSString*) phoneNumber userId:(NSString *)userId
{
    Utility* toJSON = [[Utility alloc] init];
    toJSON.firstName = firstName;
    toJSON.lastName = lastName;
    toJSON.company = company;
    toJSON.tags = tags;
    toJSON.notes = notes;
    toJSON.status = status;
    toJSON.picUrl = picUrl;
    toJSON.email = email;
    toJSON.phoneNumber = phoneNumber;
    toJSON.userId = userId;
    
    return toJSON;
}

@end
