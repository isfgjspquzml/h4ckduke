//
//  ServerResponse.h
//  inTouch
//
//  Created by Tianyu Shi on 11/17/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "JSONModel+networking.h"
#import "Utility.h"


@interface ServerResponse : JSONModel
@property(nonatomic, strong) NSArray<Utility>* response;
@end
