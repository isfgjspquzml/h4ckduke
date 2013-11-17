//
//  Utility.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by Tianyu Shi on 11/17/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol Utility @end
@interface Utility : JSONModel

@property NSString* firstName;
@property NSString* lastName;
@property NSString<Optional>* company;
@property NSArray<Optional>* tags;
@property NSString<Optional>* notes;
@property NSString* picUrl;
@property NSString* status;
@property NSString* email;
@property NSString* phoneNumber;
@property NSString* userId;
@property NSString<Optional>* _id;

+(id) initWithStringfirstName: (NSString*) firstName lastName:(NSString*)lastName company:(NSString*) company tags:(NSString*) tags notes:(NSString*) notes status:(NSString*) status picUrl:(NSString*) picUrl email:(NSString*) email phoneNumber:(NSString*) phoneNumber userId:(NSString*) userId;

@end
