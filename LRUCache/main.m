//
//  main.m
//  LRUCache
//
//  Created by waveOcean Software on 8/13/15.
//  Copyright (c) 2015 vincemansel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VM_LRUCache.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        VM_LRUCache *cache = [[VM_LRUCache alloc] initWithCapacity:3];
 
        [cache listCacheInLRUOrder];

        [cache setObject:@1 forKey:@"first"];
        [cache setObject:@2 forKey:@"second"];
        [cache setObject:@1 forKey:@"first"];
        [cache setObject:@3 forKey:@"third"];
        [cache setObject:@4 forKey:@"fourth"];
        
        [cache listCacheInLRUOrder];
        
        [cache setObject:@2 forKey:@"second"];
        
        [cache listCacheInLRUOrder];
        
        [cache setObject:@3 forKey:@"third"];

        [cache listCacheInLRUOrder];
        
        id object4 = [cache getObjectForKey:@"fourth"];

        [cache listCacheInLRUOrder];

        id object = [cache getObjectForKey:@"first"];

        [cache listCacheInLRUOrder];
        
        return 0;
    }
}
