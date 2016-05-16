//
//  Classify.m
//  dragToOrder
//
//  Created by 史秀泽 on 16/4/5.
//  Copyright © 2016年 SXZ. All rights reserved.
//

#import "Classify.h"

@implementation Classify

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.pageNum forKey:@"pageNum"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.pageNum = [decoder decodeObjectForKey:@"pageNum"];
    }
    return  self;
}
@end
