//
//  VM_LRUCache.h
//  LRUCache
//
//  Created by waveOcean Software on 8/17/15.
//  Copyright (c) 2015 vincemansel. All rights reserved.
//

#ifndef LRUCache_VM_LRUCache_h
#define LRUCache_VM_LRUCache_h

@interface VM_LRUCache : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;
- (void)setObject:(id)object forKey:(id<NSCopying>)aKey;
- (void)listCacheInLRUOrder;
- (id)getObjectForKey:(id<NSCopying>)aKey;

@end

#endif
