//
//  VM_LRUCache.m
//  LRUCache
//
//  Created by waveOcean Software on 8/17/15.
//  Copyright (c) 2015 vincemansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VM_LRUCache.h"

@interface DLLnode : NSObject

@property (strong, nonatomic) id data;
@property (strong, nonatomic) id key;
@property (strong, atomic) DLLnode *next;
@property (strong, atomic) DLLnode *prev;

@end

@implementation DLLnode
@end

@interface DoubleLinkList : NSObject

@property (readonly) DLLnode *head;
@property (readonly) DLLnode *tail;

- (DLLnode *)makeNodeWithObject:(id)object andKey:(id)aKey;
- (void) appendNode:(DLLnode *)node;
- (void) replaceHead;
- (void) moveNodeToEnd:(DLLnode *)node;

@end

@interface DoubleLinkList ()

@property (readwrite) DLLnode *head;
@property (readwrite) DLLnode *tail;

@end

@implementation DoubleLinkList

- (id)init {
    self = [super init];
    
    if (self) {
        _head = nil;
        _tail = nil;
    }
    return self;
}

- (DLLnode *)makeNodeWithObject:(id)object andKey:(id)aKey {
    DLLnode *node = [[DLLnode alloc] init];
    node.data = object;
    node.key = aKey;
    node.next = nil;
    node.prev = nil;
    
    [self appendNode:node];
    
    return node;
}

- (void)appendNode:(DLLnode *)node {
    
    if (!_head) {
        self.head = node;
        self.tail = node;
        self.head.next = nil; // sets node.next also
        self.head.prev = nil; // sets node.prev also
        
    }
    else {
        node.next = nil;
        node.prev = self.tail;
        self.tail.next = node;
        self.tail = node;
    }
}

- (void)replaceHead {
    self.head = self.head.next;
    self.head.prev = nil;
}

- (void)moveNodeToEnd:(DLLnode *)node {
    DLLnode *tempNode;
    
    if (node == self.head) {
        tempNode = node;
        [self replaceHead];
    }
    else if (node == self.tail) {
        return;
    }
    else {
        tempNode = node.prev;
        tempNode.next = node.next;
        node.next.prev = tempNode;
        tempNode = node;
    }
    
    [self appendNode:tempNode];
}

@end

@implementation VM_LRUCache
{
    NSMutableDictionary *map;
    DoubleLinkList *list;
    NSUInteger capacity;
}

- (id)initWithCapacity:(NSUInteger)aCapacity {
    self = [super init];
    
    if (self) {
        capacity = aCapacity;
        map = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        list = [[DoubleLinkList alloc] init];
    }
    return self;
}

- (void)setObject:(id)object forKey:(id<NSCopying>)aKey {
    
    DLLnode *currentNode = [map objectForKey:aKey];
    if (currentNode == nil) {
        DLLnode *node = [list makeNodeWithObject:object andKey:aKey];
        [map setObject:node forKey:aKey];
    }
    else {
        [list moveNodeToEnd:currentNode];
    }
    
    if ([map count] > capacity) {
        DLLnode *tempHead = [list head];
        [list replaceHead];
        [map removeObjectForKey:tempHead.key];
    }
}

- (void)listCacheInLRUOrder {
    DLLnode *current = list.head;
    
    if (!current) {
        NSLog(@"No items in cache");
    }
    
    while (current) {
        NSLog(@" object = %ld", (long)[current.data integerValue]);
        current = current.next;
    }
    NSLog(@"\n");
}

- (id)getObjectForKey:(id<NSCopying>)aKey {
    DLLnode *node = [map objectForKey:aKey];
    [list moveNodeToEnd:node];
    return node.data;
}

@end
